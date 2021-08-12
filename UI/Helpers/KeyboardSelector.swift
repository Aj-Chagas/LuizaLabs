//
//  KeyboardSelector.swift
//  UI
//
//  Created by Anderson Chagas on 12/08/21.
//

import UIKit

@objc
protocol KeyboardProtocol: AnyObject {
    var viewBottomConstraint: NSLayoutConstraint! { get set }
    
    @objc func keyBoardWillShow(_ sender: Notification)
    
    @objc func keyBoardWillHide()
}

protocol KeyboardSelector: KeyboardProtocol {
    func registerForKeyboardNotifications()
    func unregisterForKeyboardNotifications()
}

extension KeyboardProtocol where Self: UIViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func ajustViewToShowKeyboard(_ sender: Notification) {
        guard let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.updateScreenPositionForKeyboard(frame: keyboardFrame)
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateScreenPositionForKeyboard(frame: CGRect) {
        self.viewBottomConstraint.constant = frame.size.height + 16
        self.view.layoutIfNeeded()
    }

    func ajustViewToHideKeyboard( height: CGFloat = 0.0) {
        UIView.animate(withDuration: 0.0) {
            self.viewBottomConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
}
