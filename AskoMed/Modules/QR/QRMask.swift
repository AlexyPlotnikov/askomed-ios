//
//  QRMask.swift
//  AskoMed
//
//  Created by RX Group on 30.03.2023.
//

import UIKit

class QRMask: UIView {
    let sideWidth = 250
  
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.orange.cgColor

        let xOffset = Int(self.frame.size.width)/2 - sideWidth/2
        let yOffset = Int(self.frame.size.height)/2 - sideWidth/2
        let rect = CGRect(x: xOffset, y: yOffset, width: sideWidth, height: sideWidth)
        let path = UIBezierPath(rect: self.bounds)
        
        maskLayer.fillRule = .evenOdd
        path.append(UIBezierPath(roundedRect: rect, cornerRadius: 20))
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd

        self.layer.mask = maskLayer
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializate()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializate()
    }
  
    func initializate(){
        let label = UILabel(frame: CGRect(x: 32, y: Int(self.frame.size.height)/2 + sideWidth/2 + 22, width: Int(self.frame.size.width) - 64, height: 40))
        label.text = "Отсканируйте QR-код электронной иммунокарты застрахованного"
        label.textColor = .white
        label.font = UIFont(name: "Inter-Medium", size: 15)!
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
    }

}
