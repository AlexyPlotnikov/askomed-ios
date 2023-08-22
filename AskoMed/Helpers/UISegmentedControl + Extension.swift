//
//  UISegmentedControll.swift
//  AskoMed
//
//  Created by RX Group on 15.03.2023.
//

import Foundation
import UIKit

extension UISegmentedControl
{
    func defaultConfiguration(font: UIFont = UIFont(name: "Inter-Medium", size: 14)!, color: UIColor = UIColor.black)
    {
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }

    func selectedConfiguration(font: UIFont = UIFont(name: "Inter-Bold", size: 14)!, color: UIColor = UIColor.white)
    {
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
