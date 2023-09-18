from pynput import keyboard
import pyautogui
import win32gui


class Skype:
    def __init__(self, target_window_title: str, detection_interval: float = 0.1):
        self.target_window_title = target_window_title
        self.detection_interval = detection_interval
        self.listener = None

    def monitor(self) -> bool:
        window_object = win32gui.GetForegroundWindow()
        window_title = win32gui.GetWindowText(window_object)
        if window_title == self.target_window_title:
            return True
        return False
    
    def __on_key_release(self, key):
        self.listener.stop()
        if key == keyboard.Key.enter and self.monitor():
            pyautogui.press('enter')
    
    def logic(self) -> None:
        while True:
            self.listener = keyboard.Listener(on_release=self.__on_key_release)
            self.listener.start()
            self.listener.join()
