//
//  NewPoliceController.swift
//  AskoMed
//
//  Created by RX Group on 30.03.2023.
//

import UIKit
import RxCocoa
import RxSwift

class NewPoliceController: UIViewController, Storyboardable {

    var viewModel:NewPoliceViewModel!
    @IBOutlet weak var table: UITableView!
    var disposeBag:DisposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 128
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        self.setTap()
        self.registerForKeyboardWillHideNotification(table)
        self.registerForKeyboardWillShowNotification(table)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.viewModel.navigation.hideNavBar()
        }
    }
   
   
    

}


extension NewPoliceController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "personInfoCell", for: indexPath) as! NewPoliceCell
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "insuranceInfoCell", for: indexPath) as! NewPoliceCell
            cell.insuranceField.rx.controlEvent(.editingDidBegin)
                .asObservable()
                .subscribe(onNext: { _ in
                    self.viewModel.navigation.openInsurance()
                })
                .disposed(by: disposeBag)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "attachPhotoCell", for: indexPath) as! NewPoliceCell
            
            return cell
        }
    }
    
   

}

