//
//  CreateImunoController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import UIKit
import Alamofire

class CreateImunoController: UIViewController, Storyboardable {

    
    var viewModel:CreateImunoViewModel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var barcodeError: UILabel!
    @IBOutlet weak var IGerror: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 60
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
        self.setTap()
        registerForKeyboardWillHideNotification(self.table,usingBlock: {_ in 
            self.table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
        })
        registerForKeyboardWillShowNotification(self.table)
        
    }
    

    @objc func createNewBox(){
        self.viewModel.boxes.append(ApealImmunoglobulin(barcode: "", countMLIG: ""))
        self.table.reloadData()
    }

    @IBAction func createAppeal(_ sender: Any) {
        let summ = self.viewModel.boxes.compactMap({Int(String($0.countMLIG ?? "0"))}).reduce(0, +)
        let nullArray = self.viewModel.boxes.filter({$0.barcode == ""})
        if(summ != Int(self.viewModel.model.countMLIG!) || nullArray.count > 0){
            errorView.isHidden=false
            barcodeError.isHidden = nullArray.count == 0
            if(Int(self.viewModel.model.countMLIG!)>summ){
                IGerror.text = "Еще нужно: \(Int(self.viewModel.model.countMLIG!) - summ) мг."
            }else{
                IGerror.text = "На \(abs(Int(self.viewModel.model.countMLIG!) - summ)) мг. больше"
            }
        }else{
            self.viewModel.model.immunoglobulinBoxUsed = self.viewModel.boxes
           // self.viewModel.navigation.goResultView(model: self.viewModel.model)
            let headers: HTTPHeaders = [
                "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
                "Authorization": "Bearer \(authToken ?? "")"]
            
            let params = self.viewModel.model
            print(params)
            AF.request(
                domain + "/mobileapp/createinsurancecase", method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseDecodable(of: AppealServiceGet.self, completionHandler: {
                result in
                           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAppeal"), object: nil, userInfo: nil)
                           self.viewModel.navigation.goResultView()
            })
        }
    }
    
   
}

extension CreateImunoController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.boxes.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section + 1) > self.viewModel.boxes.count ? 1:2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section + 1) > self.viewModel.boxes.count ? "":"Коробка \(section + 1)"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if((indexPath.section + 1) > self.viewModel.boxes.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "newButtonCell", for: indexPath) as! CreateImunoCell
            cell.createBtn.addTarget(self, action: #selector(createNewBox), for: .touchUpInside)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleImunocell", for: indexPath) as! CreateImunoCell
            if(indexPath.row==0){
                cell.titleLbl.text = "Штрих-код коробки (5 цифр) *"
                cell.textField.placeholder = "Укажите штрих-код"
                cell.textField.format = "XXXXX"
            }else{
                cell.titleLbl.text = "Взято ИГ из коробки, мл. *"
                cell.textField.placeholder = "Укажите кол-во мл."
            }
            let section = indexPath.section + 1
            let row = indexPath.row + 1
            cell.textField.tag = Int("\(section)0\(row)")!
            cell.textField.addToolBar()
            
            return cell
           
        }
        
    }
    
    
}

extension CreateImunoController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        let indexString = "\(textField.tag)"
        let parts = indexString.components(separatedBy: "0")
        let row = Int(parts[1])! - 1
        let section = Int(parts[0])! - 1
        
        if(row == 0){
            self.viewModel.boxes[section].barcode = newString
        }else{
            self.viewModel.boxes[section].countMLIG = newString
        }
        

        
        return true
    }
}
