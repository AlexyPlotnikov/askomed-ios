//
//  HistoryController.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import UIKit
import SDWebImage

class HistoryController: UIViewController, Storyboardable {
    
    var viewModel:HistoryViewModel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addIconGlass()
        self.setTap()
        table.estimatedRowHeight = 166
        table.rowHeight = UITableView.automaticDimension
    }
    
    func addIconGlass(){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        let image = UIImage(named: "glassIcon")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        searchField.leftViewMode = .always
        searchField.leftView = view
    }
   

}


extension HistoryController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        
        let history = viewModel.model.historyList[indexPath.row]
        cell.insuranceImage.sd_setImage(with: URL(string: history.pathLogoInsuranceCompany!.encodeUrl)!)
        cell.dateLbl.text = history.dateCreate ?? ""
        cell.descLbl.text = "\(history.dateBirth ?? "") · \(history.numberPolicy ?? "")"
        cell.fullNameLbl.text = history.fullName ?? ""
        cell.statusCollection.tag = indexPath.row
        
        return cell
    }
    
    
}

extension HistoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statusCell", for: indexPath) as! StatusCell
        
        let history = viewModel.model.historyList[collectionView.tag]
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let history = viewModel.model.historyList[collectionView.tag]
        var width = 0.0
       
        return CGSize(width: width, height: 24)
    }
    
    
}
