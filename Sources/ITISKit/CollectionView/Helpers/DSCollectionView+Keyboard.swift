import UIKit

public extension DSCollectionView {

    func adjustContentInsetsForKeyboard(_ should: Bool) {
        
        if should {
            addKeyboardObservers()
        } else {
            removeKeyboardObservers()
        }
    }

    func addKeyboardObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidChangeFrame),
                                               name: UIResponder.keyboardDidChangeFrameNotification,
                                               object: nil)
    }
    
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        
        if isKeyboardOnScreen == false {
            storedContentInset = self.view.contentInset
            isKeyboardOnScreen = true
            adjustScroll(for: notification)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        
        isKeyboardOnScreen = false
        adjustScroll(for: notification)
    }

    @objc func keyboardDidChangeFrame(_ notification: Notification) {
        adjustScroll(for: notification)
    }

    func adjustScroll(for notification: Notification) {
        
        if let frameAndDuration = self.frameAndDuration(for: notification) {
            
            let frame = frameAndDuration.frame
            let duration = frameAndDuration.duration
            let newTableInsets = insets(for: frame)            
            
            
            DispatchQueue.main.after(0.1) {
                UIView.animate(withDuration: duration, animations: {
                    self.view.contentInset = newTableInsets
                    self.view.scrollIndicatorInsets = newTableInsets
                })
            }
        }
    }

    func frameAndDuration(for notification: Notification) -> (frame: CGRect, duration: Double)? {
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return nil
        }
        
        return (frame: keyboardFrame, duration: duration)
    }

    func insets(for keyboardFrame: CGRect) -> UIEdgeInsets {
        
        if isKeyboardOnScreen {
            
            guard let view = self.superview,
                  let mainWindowView = mainWindowView() else {
                return self.view.contentInset
            }
            
            let tableFrame = self.view.frame
            let convertedTableFrame = view.convert(tableFrame, to: view)
            let inset = keyboardFrame.intersection(convertedTableFrame).height
            let currentTableInsets = self.view.contentInset
            let topMargin = view.frame.size.height - (self.frame.size.height + self.frame.origin.y)
            let difference = mainWindowView.frame.size.height - self.frame.size.height - topMargin
            
            var bottomSafeArea: CGFloat = 0
            
            if #available(iOS 11.0, *) {
                if let bottom = superview?.safeAreaInsets.bottom {
                    bottomSafeArea = bottom
                }
            }
            
            let insets = UIEdgeInsets(top: currentTableInsets.top,
                                      left: currentTableInsets.left,
                                      bottom: (inset + difference - bottomSafeArea) + DSAppearance.shared.main.margins,
                                      right: currentTableInsets.right)
            return insets
            
        } else {
            
            if let storedContentInset = self.storedContentInset {
                return storedContentInset
            }
            
            return self.view.contentInset
        }
    }

    func mainWindowView() -> UIView? {
        
        guard let controller = UIApplication.shared.getKeyWindow()?.rootViewController else {
            return nil
        }
        
        guard (controller.navigationController != nil) else {
            return controller.view
        }
        
        return controller.navigationController?.view
    }
}

extension DSCollectionView {

    @objc func hideKeyboardWhenHitBottom() {
        
        scrollViewDidScrollForKeyboard = { [weak self] scrollView in
            guard let _self = self else {
                return
            }
            let bottom = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height + scrollView.contentInset.bottom
            if bottom < -80 {
                _self.hideKeyboard()
            }
        }
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension DSCollectionView: UIGestureRecognizerDelegate {

    func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool = false) {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }

        return true
    }

    func hideKeyboardWhenSwipeUpDown(cancelsTouchesInView: Bool = false) {
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        swipeUp.direction = .up
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        swipeDown.direction = .down
        
        swipeDown.cancelsTouchesInView = cancelsTouchesInView
        swipeUp.cancelsTouchesInView = cancelsTouchesInView
        
        self.addGestureRecognizer(swipeUp)
        self.addGestureRecognizer(swipeDown)
    }

    @objc public func dismissKeyboard() {
        self.endEditing(true)
    }
}

public extension DSCollectionView {
    
    func scrollToBottom(animated: Bool) {}
}
