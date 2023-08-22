//
//  SearchController.swift
//  AskoMed
//
//  Created by RX Group on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchController: UIViewController, Storyboardable {

   
    var viewModel:SearchViewModel!
    fileprivate var disposeBag = DisposeBag()
    var subscription: Disposable?
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindCallbacks()
        self.configUI()
    }
    
    func configUI(){
        segmentControll.defaultConfiguration()
        segmentControll.selectedConfiguration()
        table.estimatedRowHeight = 92
        table.rowHeight = UITableView.automaticDimension
    }
    
    func bindCallbacks(){
        segmentControll.rx.selectedSegmentIndex.subscribe (onNext: { index in
            self.viewModel.model = SearchEnum(index: index)
            self.table.reloadData()
        }).disposed(by: disposeBag)
        self.setTap()
       
    }
   
   
}


extension SearchController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.model {
        case .police:
            return 1
        case .card:
            return 2
      
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchContentCell", for: indexPath) as! SearchCell
            
            let searchViewValue = self.viewModel.model.searchTitleValue()
            
            
            cell.topTitle.attributedText = viewModel.getMulticolorText(text: searchViewValue.topField.fieldTitle, isRequired: searchViewValue.topField.isRequired)
            cell.topField.placeholder = searchViewValue.topField.fieldPlaceholder
            cell.bottomTitle.attributedText = viewModel.getMulticolorText(text: searchViewValue.bottomField.fieldTitle, isRequired: searchViewValue.bottomField.isRequired)
            cell.bottomField.placeholder = searchViewValue.bottomField.fieldPlaceholder
            
            switch self.viewModel.model {
            case .police:
                cell.topField.keyboardType = .default
                cell.bottomField.keyboardType = .numberPad
                cell.topField.format = ""
                cell.bottomField.format = "XX.XX.XXXX"
            case .card:
                cell.topField.keyboardType = .numberPad
                cell.bottomField.keyboardType = .numberPad
                cell.topField.format = "XX-XXX"
                cell.bottomField.format = "№XXXXXXX"
            }
            
            cell.topField.text = self.viewModel.model == .police ? viewModel.paramSend.fullName:viewModel.paramSend.series
            cell.bottomField.text = self.viewModel.model == .police ? viewModel.paramSend.dateBirth:viewModel.paramSend.number
            cell.topField.tag = 0
            cell.bottomField.tag = 1
            cell.topField.delegate = self
            cell.bottomField.delegate = self
            if(subscription != nil){
                subscription?.dispose()
            }
            
            subscription = cell.findBtn.rx.tap.subscribe(onNext: { _ in
                let headers: HTTPHeaders = [
                    "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
                    "Authorization": "Bearer \(authToken ?? "")"]
                self.viewModel.paramSend.immunocard = self.viewModel.model == .police ? false:true
                if(self.viewModel.paramSend.number.contains("№")){
                    self.viewModel.paramSend.number=self.viewModel.paramSend.number.replacingOccurrences(of: "№", with: "")
                }
                AF.request(domain + "/mobileapp/searchdocuments", method: .post,
                           parameters: self.viewModel.paramSend,
                           encoder: JSONParameterEncoder.default,
                           headers: headers).responseDecodable(of: PersonResultModel.self, completionHandler: {
                    result in
                    do{
                        self.viewModel.navigation.searchByParam(searchType: self.viewModel.model, results:try? result.result.get(),serachParam: self.viewModel.paramSend)
                    }
                        
                    
                    print(result)
                })
             
            })
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "qrCell", for: indexPath) as! SearchCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1){
            self.viewModel.navigation.openQR()
        }
    }
    
     
}


extension SearchController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch self.viewModel.model {
        case .police:
            if(textField.tag == 0){
                self.viewModel.paramSend.fullName = updatedText
            }else{
                self.viewModel.paramSend.dateBirth = updatedText
                
            }
        case .card:
            if(textField.tag == 0){
                self.viewModel.paramSend.series = updatedText
            }else{
                self.viewModel.paramSend.number = updatedText
            }
        
        }
        
        return true
    }
}
