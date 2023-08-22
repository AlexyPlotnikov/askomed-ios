//
//  DirectoryController.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import UIKit

class DirectoryController: UIViewController, Storyboardable {

    
    @IBOutlet weak var table: UITableView!
    var viewModel:DirectoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 188
        table.rowHeight = UITableView.automaticDimension
    }
    

   

}

extension DirectoryController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "findCell", for: indexPath) as! DirectoryCell
        cell.setupView()
        
        return cell
    }
    
    
}
