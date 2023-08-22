//
//  ProfileController.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import UIKit
import Alamofire

class ProfileController: UIViewController, Storyboardable {
    
    var viewModel:ProfileViewModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 74
        table.rowHeight = UITableView.automaticDimension
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let headers: HTTPHeaders = [
            "ApiKeyMobileApp": "EL8AkoRw0rqDEGKK",
            "Authorization": "Bearer \(authToken ?? "")"]
   
        AF.request(domain + "/mobileapp/profiledoctor", method: .get, headers: headers).responseDecodable(of: ProfileModel.self){
            result in
            print(result)
            self.viewModel.profile = result.value
            self.table.reloadData()
        }
    }

    @IBAction func logOut(_ sender: Any) {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите выйти из аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { action in
            UserDefaults.standard.removeObject(forKey: "token")
            self.viewModel.navigation.logOut()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension ProfileController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.profile != nil ? 2:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCardCell", for: indexPath) as! ProfileCell
            cell.fullnameLbl.text = self.viewModel.profile.fullName ?? "-"
            cell.jobLbl.text = self.viewModel.profile.role ?? "-"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MOCell", for: indexPath) as! ProfileCell
            cell.moLbl.text = self.viewModel.profile.hospitalTitle ?? "-"
            cell.adressLbl.text = self.viewModel.profile.hospitalAddress ?? "-"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1){
            self.viewModel.navigation.chooseMO()
        }
        
    }
}
