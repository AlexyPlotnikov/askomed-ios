//
//  UIViewController + Extension.swift
//  AskoMed
//
//  Created by RX Group on 15.03.2023.
//

import Foundation
import UIKit


extension UIViewController{
    func setTap(_ needCancel:Bool = false){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
               tap.cancelsTouchesInView = needCancel
               view.addGestureRecognizer(tap)
    }
    
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, bottomInset:CGFloat? = 0, usingBlock block: ((CGSize?) -> Void)? = nil) {
        print("show")
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height , right: scrollView.contentInset.right)
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }

    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView,bottomInset:CGFloat? = 0, usingBlock block: ((CGSize?) -> Void)? = nil) {
        print("hide")
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: bottomInset ?? 0, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
}

extension UIScrollView {

    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}
