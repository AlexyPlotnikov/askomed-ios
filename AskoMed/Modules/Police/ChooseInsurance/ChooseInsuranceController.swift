//
//  ChooseInsuranceController.swift
//  AskoMed
//
//  Created by RX Group on 31.03.2023.
//

import UIKit

struct InsuranceModel{
    var name:String
    var insuranceProgram:[String]
}

class ChooseInsuranceController: UIViewController, Storyboardable {
    
    var viewModel:ChooseInsuranceViewModel!
    let insurance:[InsuranceModel] = [InsuranceModel(name: "АльфаСтрахование", insuranceProgram: ["Антиклещ стандарт", "Антиклещ премиум", "Защита от клеща", "Пульс антиклещ","Для семьи расширенная"]), InsuranceModel(name: "Ингосстрах", insuranceProgram: ["Антиклещ стандарт", "Антиклещ премиум", "Защита от клеща", "Пульс антиклещ","Для семьи расширенная"]), InsuranceModel(name: "ВСК", insuranceProgram: ["Антиклещ стандарт", "Антиклещ премиум", "Защита от клеща", "Пульс антиклещ","Для семьи расширенная"])]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}


extension ChooseInsuranceController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insurance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceCell", for: indexPath) as! InsuranceCell
        
        cell.titleLbl.text = insurance[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.navigation.openInsuranceProgram(programs: insurance[indexPath.row].insuranceProgram)
    }
    
}
