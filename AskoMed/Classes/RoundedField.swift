//
//  RoundedField.swift
//  AskoMed
//
//  Created by RX Group on 10.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RoundedField: UITextField {
    fileprivate var disposeBag = DisposeBag()
    var format = ""

    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.configUI()
        self.bindFieldToColor()
    }
   
    
    func configUI(){
        self.layer.cornerRadius = 12
        self.leftPaddingPoints(16)
    }

    func bindFieldToColor(){
        self.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe(onNext: { _ in
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.init(displayP3Red: 12/255, green: 175/255, blue: 137/255, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        self.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe(onNext: { _ in
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.clear.cgColor
                
            })
            .disposed(by: disposeBag)
        
        self.rx.controlEvent(.editingChanged)
            .asObservable()
            .subscribe(onNext: {char in
                if(self.format != ""){
                    self.text = self.format(with: self.format, text: self.text ?? "")
                }
        }).disposed(by: disposeBag)
    }
    
    func format(with mask: String, text: String) -> String {
        let numbers = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
