//
//  Keyboard + Observable.swift
//  AskoMed
//
//  Created by RX Group on 09.03.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

func keyboardHeight() -> Observable<CGFloat> {
    return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                            .map { notification -> CGFloat in
                                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                            },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                            .map { _ -> CGFloat in
                                0
                            }
            ])
            .merge()
}
