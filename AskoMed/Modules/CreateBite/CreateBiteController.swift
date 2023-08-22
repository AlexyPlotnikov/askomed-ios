//
//  CreateBiteController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import UIKit

class CreateBiteController: UIViewController, Storyboardable {

    var viewModel:CreateBiteViewModel!
    @IBOutlet weak var dateField: RoundedField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateField.format = "XX.XX.XXXX"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yyyy"
        self.dateField.text = dateFormatterGet.string(from: Date())
    }
    

    @IBAction func create(_ sender: Any) {
        self.viewModel.navigation.biteCreated(bite: Bite(biteId: 0, dateBite: dateField.text))
    }
    

}
