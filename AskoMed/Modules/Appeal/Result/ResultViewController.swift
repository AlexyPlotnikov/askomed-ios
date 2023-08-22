//
//  ResultViewController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 18.07.2023.
//

import UIKit

class ResultViewController: UIViewController, Storyboardable {

    var viewModel:ResultViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func done(_ sender: Any) {
        self.viewModel.navigation.backToMain()
    }
    
}
