//
//  String + Extension.swift
//  AskoMed
//
//  Created by RX Group on 16.03.2023.
//

import Foundation
import UIKit


extension String{
       func widthOfString(usingFont font: UIFont) -> CGFloat {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.width
       }

       func heightOfString(usingFont font: UIFont) -> CGFloat {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.height
       }
}

extension String{
    var encodeUrl : String
    {
        
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
