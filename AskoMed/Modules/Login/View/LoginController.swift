//
//  LoginController.swift
//  AskoMed
//
//  Created by RX Group on 09.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire



class LoginController: UIViewController {

    var viewModel : LoginViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    @IBOutlet weak var viewTopConstant: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstant: NSLayoutConstraint!
    @IBOutlet weak var loginField: RoundedField!
    @IBOutlet weak var passwordField: RoundedField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindCallbacks()
        
    }
    
    func bindCallbacks(){
        keyboardHeight()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {  keyboardHeight in
                if(keyboardHeight == 0){
                    self.viewTopConstant.constant = keyboardHeight-70
                    self.viewBottomConstant.constant = keyboardHeight
                }else{
                    self.viewTopConstant.constant = keyboardHeight + self.view.frame.size.height * 0.57 + 70
                    self.viewBottomConstant.constant = keyboardHeight
                    
                   
                }
                    
                UIView.animate(withDuration: 1) {
                        self.view.layoutIfNeeded()
                    }
            })
            .disposed(by: disposeBag)
        
        self.setTap()
    }
    
    @IBAction func logIn(_ sender: Any) {
        if(loginField.text!.count > 0 && passwordField.text!.count > 0){
            let login = Login(login: loginField.text!, password: passwordField.text!)
            
            AF.request(domain + "/tokenjson",
                       method: .post,
                       parameters: login,
                       encoder: JSONParameterEncoder.default).responseDecodable(of: TokenJson.self) { result in
                if(result.error != nil){
                    print("ERROR")
                }else{
                    do{
                        authToken = try! result.result.get().token
                        UserDefaults.standard.set(authToken, forKey: "token")
                    }
                    
                    self.viewModel.navigation.authorization()
                }
               
            }
        }
    }
  
   

}
