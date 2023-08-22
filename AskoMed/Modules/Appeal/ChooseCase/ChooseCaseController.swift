//
//  ChooseCaseController.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class ChooseCaseController: UIViewController, Storyboardable {

    var viewModel:ChooseCaseViewModel!
    @IBOutlet weak var table: UITableView!
    fileprivate var disposeBag = DisposeBag()
    var subscription: Disposable?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 278
        table.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(chooseBite(notification:)), name: NSNotification.Name("chooseBite"), object: nil)
        self.setTap()
    }
    
    @objc func chooseBite(notification: NSNotification){
        let bite = notification.object
        self.viewModel.currentBite = (bite as! Bite)
        self.table.reloadData()
    }

    func dateFromJSON(_ JSONdate: String) -> String {
        if(JSONdate != ""){
            let dateFormatterGet = DateFormatter()
            var tempDate = JSONdate
            if let dotRange = tempDate.range(of: "T") {
                tempDate.removeSubrange(dotRange.lowerBound..<tempDate.endIndex)
            }
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
            if(dateFormatterGet.date(from: tempDate) == nil){
                dateFormatterGet.dateFormat = "dd.MM.yyyy"
            }
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            dateFormatterPrint.dateStyle = DateFormatter.Style.medium
            dateFormatterPrint.locale = NSLocale(localeIdentifier: "ru") as Locale
            
            let date = dateFormatterGet.date(from: tempDate)
            
            return dateFormatterPrint.string(from: date!)
        }else{
            return ""
        }
    }

}


extension ChooseCaseController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseCaseCell", for: indexPath) as! ChooseCaseCell
        if(subscription != nil){
            subscription?.dispose()
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yyyy"
        cell.topField.text = dateFormatterGet.string(from: Date())
        if(self.viewModel.currentBite != nil){
            cell.bottomField.text = self.dateFromJSON((self.viewModel.currentBite?.dateBite!)!)
        }
       
        cell.topField.format = "XX.XX.XXXX"
        cell.topField.delegate = self
        cell.bottomField.delegate = self
        subscription = cell.chooseBtn.rx.tap.subscribe(onNext: { _ in
            cell.topField.resignFirstResponder()
            if(self.viewModel.currentBite != nil){
                let headers: HTTPHeaders = [
                    "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
                    "Authorization": "Bearer \(authToken ?? "")"]
                let params = SendChooseAppeal(documentid: self.viewModel.documentID, letterGuaranteeId: 0)
                AF.request(
                    domain + "/mobileapp/getservices", method: .post,
                           parameters: params,
                           encoder: JSONParameterEncoder.default,
                           headers: headers).responseDecodable(of: ServicesAppeal.self, completionHandler: {
                    result in
                               print(result)
                               self.viewModel.navigation.chooseCase(services:result.value!, dates: (cell.topField.text ?? "", cell.bottomField.text ?? ""),documentID: self.viewModel.documentID)
                })
            }
        })
        
        return cell
    }
    
    
}

extension ChooseCaseController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField.tag == 1){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.view.endEditing(true)
            }
           
            self.viewModel.navigation.createBite(documentID: self.viewModel.documentID, bites: self.viewModel.bites)
        }
    }
    
    
}
