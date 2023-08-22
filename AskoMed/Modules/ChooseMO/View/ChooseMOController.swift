//
//  ChooseMOController.swift
//  AskoMed
//
//  Created by RX Group on 10.03.2023.
//

import UIKit

class ChooseMOController: UIViewController {
    var viewModel : ChooseMOViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
    }
    


}

extension ChooseMOController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moCell", for: indexPath) as! ChooseMOCell
        
        let mo = self.viewModel.model[indexPath.row]
        cell.titleLbl.text = mo.title
        cell.descLbl.text = mo.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mo = self.viewModel.model[indexPath.row]
        self.viewModel.chooseMO(mo: mo.hospitalId ?? 0)
    }
    
    
}
