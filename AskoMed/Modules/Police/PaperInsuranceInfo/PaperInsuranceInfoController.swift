//
//  PaperInsuranceInfoController.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit

class PaperInsuranceInfoController: UIViewController, Storyboardable {
    
    var viewModel:PaperInsuranceInfoViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 72
        table.rowHeight = UITableView.automaticDimension
    }
    

    
    @IBAction func acceptInsurance(_ sender: Any) {
        self.viewModel.navigation.acceptInsuranse()
    }
    
}

extension PaperInsuranceInfoController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! PaperInfoCell
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCell", for: indexPath) as! PaperInfoCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1){
            if let url = URL(string: "tel://+78007070594") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
                
            }
        }
    }
    
}
