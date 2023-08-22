//
//  PaperPoliceController.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit

class PaperPoliceController: UIViewController,Storyboardable {

    var viewModel:PaperPoliceViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 244
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        self.setTap()
        self.registerForKeyboardWillHideNotification(table)
        self.registerForKeyboardWillShowNotification(table)
    }
    
    @IBAction func createPolice(_ sender: Any) {
        self.viewModel.navigation.hideNavBar()
        self.viewModel.navigation.createPaperPolice()
    }
    
   
    
}

extension PaperPoliceController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "personInfoCell", for: indexPath) as! PaperPoliceCell
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceInfoCell", for: indexPath) as! PaperPoliceCell
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "attachPhotoCell", for: indexPath) as! PaperPoliceCell
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2){
            self.viewModel.navigation.openCamera()
        }
    }
    
}
