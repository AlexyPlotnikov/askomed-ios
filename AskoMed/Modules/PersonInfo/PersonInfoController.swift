//
//  PersonInfoController.swift
//  AskoMed
//
//  Created by Алексей Плотников on 15.07.2023.
//

import UIKit
import Alamofire

class PersonInfoController: UIViewController, Storyboardable {

    var viewModel:PersonInfoViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
        AF.request(
            domain + "/mobileapp/documentdata?documentid=\(self.viewModel.documentID ?? 0)", method: .get,
                   headers: headers).responseDecodable(of: PersonInfoDetail.self, completionHandler: {
            result in
                       print(result)
                       self.viewModel.mapDataByKey(details: result.value!)
                       self.table.reloadData()
                   
                       
          
        })
       
    }
    

   

}

extension PersonInfoController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.personCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! PersonInfoCell
        let personInfo = self.viewModel.personCells[indexPath.row]
        
        cell.titleLbl.text = personInfo.title
        if(personInfo.key == "status"){
            cell.titleLbl.textColor = personInfo.title == "Активна" ? UIColor.init(displayP3Red: 39/255, green: 142/255, blue: 118/255, alpha: 1):UIColor.init(displayP3Red: 167/255, green: 28/255, blue: 16/255, alpha: 1)
            cell.titleLbl.backgroundColor = personInfo.title == "Активна" ? UIColor.init(displayP3Red: 39/255, green: 142/255, blue: 118/255, alpha: 0.2):UIColor.init(displayP3Red: 167/255, green: 28/255, blue: 16/255, alpha: 0.1)
            cell.titleLbl.textAlignment = .center
            cell.titleLbl.layer.cornerRadius = 10
            cell.titleLbl.layer.masksToBounds = true
        }else{
            cell.titleLbl.textColor = .black
            cell.titleLbl.backgroundColor = .clear
            cell.titleLbl.textAlignment = .left
        }
        cell.widthTitle.constant = personInfo.title.widthOfString(usingFont: UIFont(name: "Inter-Medium", size: 15)!) + 10
        cell.descLbl.text = personInfo.desc
        cell.icon.image = UIImage(named: personInfo.icon)
        
        return cell
    }


}
