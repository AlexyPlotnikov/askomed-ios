//
//  SeroprophylacticsController.swift
//  AskoMed
//
//  Created by RX Group on 07.04.2023.
//

import UIKit

class SeroprophylacticsController: UIViewController, Storyboardable {

    var viewModel:SeroprohylacticsViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTap()
        table.estimatedRowHeight = 278
        table.rowHeight = UITableView.automaticDimension
        registerForKeyboardWillHideNotification(self.table)
        registerForKeyboardWillShowNotification(self.table)
    }
    
    @IBAction func createImuno(_ sender: Any) {

        self.viewModel.navigation.createImuno(model: self.viewModel.model)
    }
    

   
}


extension SeroprophylacticsController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.needComment ? 2:1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "calculateCell", for: indexPath) as! SeroprophyCell
            cell.topField.addToolBar()
            cell.bottomField.addToolBar()
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentInfoCell", for: indexPath) as! SeroprophyCell
            cell.commentField.addToolBar()
            
            return cell
        }
    }
    
    
}

extension SeroprophylacticsController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag == 1){
            if(self.viewModel.needComment){
                self.table.reloadData()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        if(textField.tag == 0){
            self.viewModel.model.patientWeight = Int(newString) ?? 0
            self.viewModel.needComment = false
            self.viewModel.model.countMLIG = Int(round(Double(Int(newString) ?? 0) / 10.0))
            let index = IndexPath(row: 0, section: 0)
            let cell = self.table.cellForRow(at: index) as! SeroprophyCell
            cell.bottomField.text = "\(self.viewModel.model.countMLIG ?? 0)"
        }else if(textField.tag == 1){
            self.viewModel.model.countMLIG = Int(round(Double(Int(newString) ?? 0) / 10.0))
            self.viewModel.needComment = true
        }else{
            self.viewModel.model.noteIG = newString
        }
        
        return true
    }
}
