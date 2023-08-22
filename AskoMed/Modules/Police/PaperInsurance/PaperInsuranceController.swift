//
//  PaperInsuranceController.swift
//  AskoMed
//
//  Created by RX Group on 03.04.2023.
//

import UIKit

class PaperInsuranceController: UIViewController, Storyboardable {

    
    @IBOutlet weak var table: UITableView!
    var viewModel:PaperInsuranceViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 246
        table.rowHeight = UITableView.automaticDimension
    }
    

    @IBAction func chooseInsurance(_ sender: Any) {
        self.viewModel.navigation.chooseInsuranse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.viewModel.navigation.hideNavBar()
        }
    }

}

extension PaperInsuranceController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paperInsCell", for: indexPath) as! PaperInsuranceCell
        if(!self.viewModel.paramSend.series.isEmpty && !self.viewModel.paramSend.number.isEmpty){
            cell.seriesField.text = self.viewModel.paramSend.series
            cell.numberField.text = self.viewModel.paramSend.number
        }
        
        return cell
    }
    
    
}
