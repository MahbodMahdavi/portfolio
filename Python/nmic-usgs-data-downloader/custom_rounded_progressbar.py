# custom_rounded_progressbar.py (Trench and Raised Fill Visual)

from PySide6.QtWidgets import QProgressBar
from PySide6.QtGui import QPainter, QColor, QPen
from PySide6.QtCore import Qt, QRectF

class RoundedProgressBar(QProgressBar):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._bar_color = QColor("#fbc02d")  # Golden yellow
        self._show_text = False
        self.setTextVisible(True)
        self.setMinimum(0)
        self.setMaximum(100)

    def setBarColor(self, color_str):
        self._bar_color = QColor(color_str)
        self.update()

    def showText(self, visible: bool):
        self._show_text = visible
        self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        rect = self.rect()
        radius = rect.height() / 2

        painter.setRenderHint(QPainter.Antialiasing)
        painter.setPen(Qt.NoPen)

        # Draw trench background (concave channel)
        painter.setBrush(QColor("#e0e0e0"))
        painter.drawRoundedRect(rect, radius, radius)

        # TEMP: Frame disabled
        # pen = QPen(QColor("#888"))
        # pen.setWidth(0)
        # painter.setPen(pen)
        # painter.setBrush(Qt.NoBrush)
        # painter.drawRoundedRect(rect.adjusted(0, 1, -1, -1), radius, radius)

        # Calculate fill area
        progress = (self.value() - self.minimum()) / (self.maximum() - self.minimum())
        fill_width = rect.width() * progress

        # Create raised bar effect by offsetting slightly above trench
        fill_rect = QRectF(rect.left(), rect.top() - 1, fill_width, rect.height() + 2)

        painter.setBrush(self._bar_color)
        painter.setPen(Qt.NoPen)
        painter.drawRoundedRect(fill_rect, fill_rect.height() / 2, fill_rect.height() / 2)

        # Progress text
        if self._show_text:
            text = f"{self.value()}%"
            font = painter.font()
            font.setPointSize(7)
            painter.setFont(font)

            # Dark label base
            painter.setPen(QPen(Qt.black))
            text_rect = rect.adjusted(0, -2, 0, -1)
            painter.drawText(text_rect, Qt.AlignCenter, text)

            # Light label overlay inside filled region
            painter.setClipRect(fill_rect)
            painter.setPen(QPen(Qt.white))
            painter.drawText(text_rect, Qt.AlignCenter, text)
