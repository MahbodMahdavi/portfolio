# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'nmic_web_scrapermxRksl.ui'
##
## Created by: Qt User Interface Compiler version 6.8.2
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QBrush, QColor, QConicalGradient, QCursor,
    QFont, QFontDatabase, QGradient, QIcon,
    QImage, QKeySequence, QLinearGradient, QPainter,
    QPalette, QPixmap, QRadialGradient, QTransform)
from PySide6.QtWidgets import (QApplication, QComboBox, QFrame, QGroupBox,
    QLabel, QMainWindow, QProgressBar, QPushButton,
    QSizePolicy, QWidget)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        if not MainWindow.objectName():
            MainWindow.setObjectName(u"MainWindow")
        MainWindow.resize(490, 205)
        self.centralwidget = QWidget(MainWindow)
        self.centralwidget.setObjectName(u"centralwidget")
        self.pubSelection = QGroupBox(self.centralwidget)
        self.pubSelection.setObjectName(u"pubSelection")
        self.pubSelection.setGeometry(QRect(9, 0, 471, 75))
        self.label = QLabel(self.pubSelection)
        self.label.setObjectName(u"label")
        self.label.setGeometry(QRect(11, 35, 101, 16))
        self.comboBox = QComboBox(self.pubSelection)
        self.comboBox.addItem("")
        self.comboBox.addItem("Commodity")
        self.comboBox.addItem("Region")
        self.comboBox.setObjectName(u"comboBox")
        self.comboBox.setGeometry(QRect(120, 35, 341, 20))
        self.downloadGroup = QGroupBox(self.centralwidget)
        self.downloadGroup.setObjectName(u"downloadGroup")
        self.downloadGroup.setGeometry(QRect(9, 75, 471, 75))
        self.label_2 = QLabel(self.downloadGroup)
        self.label_2.setObjectName(u"label_2")
        self.label_2.setGeometry(QRect(11, 36, 101, 16))
        self.pushButton = QPushButton(self.downloadGroup)
        self.pushButton.setObjectName(u"pushButton")
        self.pushButton.setGeometry(QRect(390, 35, 71, 21))
        self.frame = QFrame(self.downloadGroup)
        self.frame.setObjectName(u"frame")
        self.frame.setGeometry(QRect(120, 36, 261, 19))
        self.frame.setFrameShape(QFrame.Shape.StyledPanel)
        self.frame.setFrameShadow(QFrame.Shadow.Raised)
        self.frame.setStyleSheet("QFrame { border: 1 solid #888; }")

        self.lineEdit_path = QLabel(self.frame)  # ✅ Only this one retained
        self.lineEdit_path.setObjectName(u"lineEdit_path")
        self.lineEdit_path.setGeometry(QRect(0, 0, 261, 19))
        self.lineEdit_path.setStyleSheet("""
            QLabel {
                background-color: #e0e0e0;
                border: 1px solid #aaa;
                border-radius: 1px;
                padding: 2px 6px;
            }
        """)

        self.downloadGroup_3 = QGroupBox(self.centralwidget)
        self.downloadGroup_3.setObjectName(u"downloadGroup_3")
        self.downloadGroup_3.setGeometry(QRect(9, 150, 471, 75))
        self.progressBar = QProgressBar(self.downloadGroup_3)
        self.progressBar.setObjectName(u"progressBar")
        self.progressBar.setGeometry(QRect(10, 35, 451, 10))
        self.progressBar.setValue(0)
        self.label_8 = QLabel(self.downloadGroup_3)
        self.label_8.setObjectName(u"label_8")
        self.label_8.setGeometry(QRect(10, 46, 251, 16))
        self.label_9 = QLabel(self.downloadGroup_3)
        self.label_9.setObjectName(u"label_9")
        self.label_9.setGeometry(QRect(260, 46, 121, 20))
        self.label_9.setAlignment(Qt.AlignmentFlag.AlignRight|Qt.AlignmentFlag.AlignTrailing|Qt.AlignmentFlag.AlignVCenter)
        self.pushButton_4 = QPushButton(self.downloadGroup_3)
        self.pushButton_4.setObjectName(u"pushButton_4")
        self.pushButton_4.setGeometry(QRect(390, 46, 71, 20))
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)

        QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        self.pubSelection.setTitle(QCoreApplication.translate("MainWindow", u"Publication", None))
        self.label.setText(QCoreApplication.translate("MainWindow", u"Publication type:", None))
        self.comboBox.setItemText(0, QCoreApplication.translate("MainWindow", u" ", None))
        self.comboBox.setItemText(1, QCoreApplication.translate("MainWindow", u"Commodity", None))
        self.comboBox.setItemText(2, QCoreApplication.translate("MainWindow", u"Region", None))
        self.downloadGroup.setTitle(QCoreApplication.translate("MainWindow", u"Destination Folder", None))
        self.label_2.setText(QCoreApplication.translate("MainWindow", u"Download to:", None))
        self.pushButton.setText(QCoreApplication.translate("MainWindow", u"...", None))
        self.lineEdit_path.setText("")
        self.downloadGroup_3.setTitle(QCoreApplication.translate("MainWindow", u"Download Progress", None))
        self.label_8.setText(QCoreApplication.translate("MainWindow", u"Waiting...", None))
        self.label_9.setText(QCoreApplication.translate("MainWindow", u"Time elapsed: 00:00", None))
        self.pushButton_4.setText(QCoreApplication.translate("MainWindow", u"Start", None))
