//
//  SearchResultController.swift
//  AskoMed
//
//  Created by RX Group on 20.03.2023.
//

import UIKit
import SDWebImage

class SearchResultController: UIViewController, Storyboardable {

    var viewModel:SearchResultViewModel!
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
        let searchParam = self.viewModel.searchParam
        searchField.text = searchParam!.immunocard ? "\(searchParam!.series), \(searchParam!.number)":"\(searchParam!.fullName), \(searchParam!.dateBirth)"
        searchField.delegate = self
    }
   
    @IBAction func back(_ sender: Any) {
        self.viewModel.navigation.back()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension SearchResultController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! SearchResultViewCell

        let history = viewModel.model.items[indexPath.row]
      
            cell.insuranceImage.sd_setImage(with: URL(string: history.pathLogoInsuranceCompany!.encodeUrl))
        
            
        cell.dateLbl.text = self.dateFromJSON(history.dateCreate ?? "")
        cell.descLbl.text = "\(self.dateFromJSON(history.dateBirth ?? "")) · \(history.numberPolicy ?? "")"
        cell.fullNameLbl.text = history.fullName ?? ""
        cell.collectionView.tag = indexPath.row

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.model.items[indexPath.row]
        self.viewModel.navigation.chooseResult(person: person)
    
    }
    
    func dateFromJSON(_ JSONdate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if(dateFormatterGet.date(from: JSONdate) == nil){
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        }
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        dateFormatterPrint.dateStyle = DateFormatter.Style.short
        dateFormatterPrint.locale = NSLocale(localeIdentifier: "ru") as Locale
        
        let date = dateFormatterGet.date(from: JSONdate)
        
        return dateFormatterPrint.string(from: date!)
    }


}

extension SearchResultController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statusCell", for: indexPath) as! StatusCell
        
        let history = viewModel.model.items[collectionView.tag]
        
        cell.statusLbl.text = history.tags[indexPath.row].title
        cell.statusLbl.backgroundColor = self.hexStringToUIColor(hex: history.tags[indexPath.row].backGroundColor ?? "")
        cell.statusLbl.textColor =  self.hexStringToUIColor(hex: history.tags[indexPath.row].textColor ?? "")
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let history = viewModel.model.items[collectionView.tag]
        let width = (history.tags[indexPath.row].title?.widthOfString(usingFont: UIFont(name: "Inter-Medium", size: 13)!) ?? 0) + 20
        
        return CGSize(width: width, height: 24)
    }
    
    
}

extension SearchResultController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.navigation.back()
    }
}
