# main_app_fusion.py

import sys
import os
import time
from PySide6.QtWidgets import (
    QApplication, QWidget, QMainWindow, QFileDialog, QLabel, QPushButton,
    QVBoxLayout, QHBoxLayout, QFrame, QStyleFactory
)
from PySide6.QtCore import Qt, QTimer, QPoint, QSettings, QThread, Signal
from PySide6.QtGui import QPixmap, QIcon
from gui import Ui_MainWindow
from custom_rounded_progressbar import RoundedProgressBar
import v1_downloader
import v3_downloader


class DownloaderWorker(QThread):
    progress = Signal(int)
    status = Signal(str)

    def __init__(self, download_path, mode):
        super().__init__()
        self.download_path = download_path
        self.mode = mode  # "region" or "commodity"

    def run(self):
        try:
            if self.mode == "commodity":
                v1_downloader.run_v1_download(self.download_path, self.status.emit, self.progress.emit)
            elif self.mode == "region":
                v3_downloader.run_v3_download(self.download_path, self.status.emit, self.progress.emit)
            self.status.emit("Download complete.")
            self.progress.emit(100)
        except Exception as e:
            self.status.emit(f"Error: {str(e)}")


class MainApp(QWidget):
    def __init__(self):
        super().__init__()
        QApplication.setStyle(QStyleFactory.create("Fusion"))

        self.dot_index = 0
        self.current_region = None
        self.last_status_text = ""
        self.last_progress_value = -1

        self.dot_timer = QTimer()
        self.dot_timer.timeout.connect(self.animate_status_dots)

        self.setWindowFlags(Qt.FramelessWindowHint | Qt.Window)
        self.setFixedSize(490, 270)
        self.setStyleSheet("background-color: #f0f0f0;")

        config_dir = os.path.join(os.getenv("LOCALAPPDATA"), "NMIC_WebScraper")
        os.makedirs(config_dir, exist_ok=True)
        config_path = os.path.join(config_dir, "settings.ini")
        self.settings = QSettings(config_path, QSettings.IniFormat)

        self.titleBar = QFrame()
        self.titleBar.setFixedHeight(32)
        self.titleBar.setStyleSheet("background-color: #012a4a;")

        self.titleIcon = QLabel()
        self.titleIcon.setPixmap(QPixmap("usgs_logo_blue.png").scaled(44, 44, Qt.KeepAspectRatio, Qt.SmoothTransformation))
        self.titleIcon.setFixedSize(48, 44)
        self.titleIcon.setStyleSheet("margin-left: 6px; margin-bottom: 10px;")
        self.titleIcon.setAlignment(Qt.AlignVCenter)

        self.titleLabel = QLabel("  NMIC Web Scraper Tool")
        self.titleLabel.setStyleSheet("color: white; font-weight: bold; margin-bottom: 2px;")

        self.closeButton = QPushButton("×")
        self.closeButton.setFixedSize(32, 32)
        self.closeButton.setStyleSheet("""
            QPushButton {
                background-color: #012a4a;
                color: white;
                border: none;
            }
            QPushButton:hover {
                background-color: #b71c1c;
            }
        """)
        self.closeButton.clicked.connect(self.close)

        titleLayout = QHBoxLayout(self.titleBar)
        titleLayout.setContentsMargins(0, 0, 0, 0)
        titleLayout.setSpacing(0)
        titleLayout.addWidget(self.titleIcon)
        titleLayout.addWidget(self.titleLabel)
        titleLayout.addStretch()
        titleLayout.addWidget(self.closeButton)

        self.main = QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self.main)
        from PySide6.QtGui import QIcon
        if getattr(sys, 'frozen', False):
            base_path = sys._MEIPASS
        else:
            base_path = os.path.abspath(".")

        icon_path = os.path.join(base_path, "usgs_logo_blue.ico")
        self.main.setWindowIcon(QIcon(icon_path))


        
        self.ui.progressBar.deleteLater()
        self.ui.progressBar = RoundedProgressBar(self.ui.downloadGroup_3)
        self.ui.progressBar.setGeometry(12, 34, 445, 7)
        self.ui.progressBar.setValue(0)
        self.ui.progressBar.setFixedHeight(5)
        self.ui.progressBar.setMinimum(0)
        self.ui.progressBar.setMaximum(100)
        self.ui.progressBar.setTextVisible(True)
        self.ui.progressBar.setBarColor("#0E7490")

        last_path = self.settings.value("last_download_path", "")
        if last_path:
            self.ui.lineEdit_path.setText(last_path)

        self.selection = None
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_elapsed_time)

        self.ui.comboBox.currentIndexChanged.connect(self.on_selection_change)
        self.ui.pushButton.clicked.connect(self.select_folder)
        self.ui.pushButton_4.clicked.connect(self.start_download)

        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)
        layout.addWidget(self.titleBar)
        layout.addWidget(self.main.centralWidget())

        self._start_pos = None
        self.start_time = None

    def animate_status_dots(self):
        if self.current_region is None:
            return
        dots = '.' * self.dot_index
        text = f"Downloading: {self.current_region}{dots}"
        if self.last_status_text != text:
            self.ui.label_8.setText(text)
            self.last_status_text = text
        self.dot_index = (self.dot_index + 1) % 4

    def handle_status_update(self, message):
        if message.startswith("Downloading: "):
            region = message.replace("Downloading: ", "").replace("...", "").strip()
            if region != self.current_region:
                self.current_region = region
                self.dot_index = 0
                self.dot_timer.start(300)
        else:
            self.dot_timer.stop()
            if self.last_status_text != message:
                self.ui.label_8.setText(message)
                self.last_status_text = message

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton and self.titleBar.rect().contains(event.position().toPoint()):
            self._start_pos = event.globalPosition().toPoint() - self.frameGeometry().topLeft()
            event.accept()

    def mouseMoveEvent(self, event):
        if self._start_pos and event.buttons() == Qt.LeftButton:
            self.move(event.globalPosition().toPoint() - self._start_pos)
            event.accept()

    def mouseReleaseEvent(self, event):
        self._start_pos = None

    def select_folder(self):
        folder = QFileDialog.getExistingDirectory(self, "Select Download Folder")
        if folder:
            self.ui.lineEdit_path.setText(folder)
            self.settings.setValue("last_download_path", folder)

    def on_selection_change(self, index):
        self.selection = self.ui.comboBox.currentText()
        text = f"Selected: {self.selection}"
        if self.last_status_text != text:
            self.ui.label_8.setText(text)
            self.last_status_text = text

    def start_download(self, region_trigger=False):
        self.ui.progressBar.setMinimum(0)
        self.ui.progressBar.setMaximum(100)
        self.update_progress_bar(0)
        path = self.ui.lineEdit_path.text().strip()
        if not path:
            msg = "Please select a valid download folder."
            if self.last_status_text != msg:
                self.ui.label_8.setText(msg)
                self.last_status_text = msg
            return

        msg = "Preparing to download..."
        if self.last_status_text != msg:
            self.ui.label_8.setText(msg)
            self.last_status_text = msg

        self.update_progress_bar(0)
        self.ui.progressBar.setTextVisible(True)

        self.start_time = time.time()
        self.timer.start(1000)

        if self.selection == "Region":
            self.run_downloader("region")
        elif self.selection == "Commodity":
            self.run_downloader("commodity")

    def run_downloader(self, mode):
        selected_path = self.ui.lineEdit_path.text().strip()
        self.downloader = DownloaderWorker(selected_path, mode=mode)
        self.downloader.progress.connect(self.update_progress_bar)
        self.downloader.status.connect(self.handle_status_update)
        self.downloader.start()

    def update_progress_bar(self, value):
        if value != self.last_progress_value:
            self.ui.progressBar.setValue(value)
            self.last_progress_value = value

    def update_elapsed_time(self):
        elapsed = int(time.time() - self.start_time)
        minutes = elapsed // 60
        seconds = elapsed % 60
        self.ui.label_9.setText(f"Time elapsed: {minutes:02}:{seconds:02}")

    def closeEvent(self, event):
        if hasattr(self, 'downloader') and self.downloader.isRunning():
            self.downloader.quit()
            self.downloader.wait()
        event.accept()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainApp()
    window.show()
    sys.exit(app.exec())
