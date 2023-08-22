//
//  InsuranceProgramController.swift
//  AskoMed
//
//  Created by RX Group on 31.03.2023.
//

import UIKit

class InsuranceProgramController: UIViewController, Storyboardable {
    
    var viewModel:InsuranceProgramViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  

}


extension InsuranceProgramController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.insuranceProgram.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceProgramCell", for: indexPath) as! InsuranceProgramCell
        
        cell.titleLbl.text = self.viewModel.insuranceProgram[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.navigation.closeInsuranse()
    }
    
    
}
