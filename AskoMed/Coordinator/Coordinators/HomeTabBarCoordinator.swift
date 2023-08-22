//
//  HomeTabBarCoordinator.swift
//  AskoMed
//
//  Created by RX Group on 14.03.2023.
//

import Foundation
import UIKit

struct TabBarPage{
    var name:String
    var controller: UIViewController
    var imageName:String
}



class HomeTabBarCoordinator: Coordinator{
    
    
   
    
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
       let searchVC = SearchController.createSearch(with: "searchVC")
       let historyVC = HistoryController.createMenu(with:"historyVC")
       let directoryVC = DirectoryController.createDirectory(with: "directoryVC")
       let profileVC = ProfileController.createProfile(with: "profileVC")

       searchVC.viewModel = SearchViewModel.init(navigationController: self)
       historyVC.viewModel = HistoryViewModel.init(navigationController: self)
       directoryVC.viewModel = DirectoryViewModel.init(navigationController: self)
       profileVC.viewModel = ProfileViewModel.init(navigationController: self)

       let tabPages = [TabBarPage(name: "Поиск", controller: searchVC, imageName: "searchIcon"),
                       TabBarPage(name: "История", controller: historyVC, imageName: "historyIcon"),
                       TabBarPage(name: "Справочник СП", controller: directoryVC, imageName: "directoryIcon"),
                       TabBarPage(name: "Профиль", controller: profileVC, imageName: "profileIcon") ]
        self.createTabBar(tabs: tabPages)

    }
    
    func createTabBar(tabs:[TabBarPage]){
        let tabBar = MainTabBarController()
        
        var vctabBar:[UIViewController] = []
        for i in 0..<tabs.count{
            let tab = tabs[i]
            vctabBar.append(self.createNavController(for: tab.controller, title: tab.name, image:UIImage(named: tab.imageName)! ))
        }

        tabBar.setupVCs(viewControllers: vctabBar)
       
        self.navigationController.pushViewController(tabBar, animated: true)
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                                      image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.setNavigationBarHidden(true, animated: true)
        rootViewController.navigationItem.title = title
        return navController
    }
}
//MARK: Поиск сотрудников
extension HomeTabBarCoordinator:SearchNavigation, SearchResultNavigation, PersonDetailNavigation, QRNavigation, PersonInfoNavigation, ServiceInfoNavigation, BiteNavigation,ServiceHistoryNavigation{
   
    
    
    func showHistoryService(appeal: AppealItem) {
        let historyServiceVC = ServiceHistoryController.createSearch(with: "serviceHistoryVC")
        let viewModel = ServiceHistoryViewModel(navigationController: self, appeal: appeal)
        historyServiceVC.viewModel = viewModel
        
        navigationController.pushViewController(historyServiceVC, animated: true)
    }
    
    
    func showBites(bites:[Bite]) {
        let bitesVC = BiteController.createSearch(with: "biteVC")
        let viewModel = BiteViewModel.init(navigationController: self, bites: bites)
        bitesVC.viewModel = viewModel
        
        
        navigationController.present(bitesVC, animated: true)
    }
    
    func showPersonInfo(documentID:Int, fullName:String) {
        let personInfoVC = PersonInfoController.createSearch(with: "personInfoVC")
        let viewModel = PersonInfoViewModel(navigationController: self, documentID: documentID, fullName: fullName)
        personInfoVC.viewModel = viewModel
        
        navigationController.pushViewController(personInfoVC, animated: true)
    }
    
    func showServiceInfo(documentID:Int){
        let serviceInfoVC = ServiceInfoController.createSearch(with: "seviceInfoVC")
        let viewModel = ServiceInfoViewModel(navigationController: self, documentID: documentID)
        serviceInfoVC.viewModel = viewModel
        
        navigationController.pushViewController(serviceInfoVC, animated: true)
    }
    
    func newAppeal(documentID:Int, bites:[Bite]) {
        let chooseCaseController = ChooseCaseController.createAppeal(with: "chooseCaseVC")
        let viewModel = ChooseCaseViewModel(navigationController: self, documentID: documentID, bites: bites)
        chooseCaseController.viewModel = viewModel
        
        
        navigationController.pushViewController(chooseCaseController, animated: true)
    }
    
    func openQR() {
        
        let qrViewController = QRController.createSearch(with: "qrVC")
        let viewModel = QRViewModel(navigationController: self)
        qrViewController.viewModel = viewModel
        
        navigationController.pushViewController(qrViewController, animated: true)
    }
    
    
    func chooseResult(person: Insured) {
        print("123456")
        let personDetailController = PersonDetailController.createSearch(with: "detailVC")
        let personDetailViewModel = PersonDetailViewModel(navigationController: self)
        personDetailViewModel.model = person
        personDetailController.viewModel = personDetailViewModel
        navigationController.setNavigationBarHidden(false, animated: false)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(personDetailController, animated: true)
    }
    
    func hideNavBar() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
    
    func searchByParam(searchType: SearchEnum, results: PersonResultModel? , serachParam:SearchParam) {
        if(results?.items.count ?? 0 > 0){
            let searchResultController = SearchResultController.createSearch(with: "searchResultVC")
            
            let searchResultViewModel = SearchResultViewModel.init(navigationController: self)
            searchResultViewModel.model = results
            searchResultViewModel.searchParam = serachParam
            searchResultController.viewModel = searchResultViewModel
            
            navigationController.pushViewController(searchResultController, animated: true)
        }else{
            if(searchType == .police){
                let newPoliceController = NewPoliceController.createPolice(with: "newPoliceVC")
                let newPoliceViewModel = NewPoliceViewModel(navigationController: self)
                
                newPoliceController.viewModel = newPoliceViewModel
                navigationController.setNavigationBarHidden(false, animated: false)
                
                let backButton = UIBarButtonItem()
                backButton.title = "Назад"
                navigationController.navigationBar.topItem?.backBarButtonItem = backButton
                navigationController.pushViewController(newPoliceController, animated: true)
            }else{
                let newPoliceController = PaperInsuranceController.createPolice(with: "paperInsVC")
                let newPoliceViewModel = PaperInsuranceViewModel(navigationController: self)
                
                newPoliceController.viewModel = newPoliceViewModel
                navigationController.setNavigationBarHidden(false, animated: false)
                
                let backButton = UIBarButtonItem()
                backButton.title = "Назад"
                navigationController.navigationBar.topItem?.backBarButtonItem = backButton
                navigationController.pushViewController(newPoliceController, animated: true)
            }
        }
    }
    
}

//MARK: Созадние обращения
extension HomeTabBarCoordinator:ChooseCaseNavigation, AppealServiceNavigation, BiteChooseNavigation, CreateBiteNavigation, SeropropylacticsNavigation,CreateImunoNavigation, ResultNavigation{
    func backToMain() {
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        let personVC = viewControllers[viewControllers.count - 6] as! PersonDetailController
        navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.popToViewController(personVC, animated: true)
    }
    
    
    
    func goResultView() {
        let resultVC = ResultViewController.createAppeal(with: "resultVC")
        let viewModel = ResultViewModel.init(navigationController: self)
        resultVC.viewModel = viewModel
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(resultVC, animated: true)
    }
    
    
    func createImuno(model:AppealServiceSend) {
        let createImuno = CreateImunoController.createAppeal(with: "createImunoVC")
        let viewModel = CreateImunoViewModel.init(navigationController: self, model: model)
        createImuno.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(createImuno, animated: true)
    }
    
    
    func biteCreated(bite: Bite) {
        let n: Int! = self.navigationController.viewControllers.count
        let myUIViewController = self.navigationController.viewControllers[n-2] as! ChooseCaseController
        myUIViewController.viewModel.bites.append(bite)
        myUIViewController.viewModel.bites.sort(by: {$0.dateBite! > $1.dateBite!})
        navigationController.popViewController(animated: true)
    }
    
    func createNewBite() {
        let biteChooseController = CreateBiteController.createSearch(with: "createBiteVC")
        
        let viewModel = CreateBiteViewModel.init(navigationController: self)
        biteChooseController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(biteChooseController, animated: true)
    }
    
    func chooseBite() {
        
    }
    
    func createBite(documentID:Int, bites: [Bite]) {
        let biteChooseController = BiteChooseController.createAppeal(with: "biteChooseVC")
        
        let viewModel = BiteChooseViewModel.init(navigationController: self, bites: bites, documentID: documentID)
        biteChooseController.viewModel = viewModel
        
        navigationController.present(biteChooseController, animated: true)
    }
    
    func chooseServices() {
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        let personVC = viewControllers[viewControllers.count - 3] as! PersonDetailController
        
        self.navigationController.popToViewController(personVC, animated: true)
    }
    
    func chooseCase(services:ServicesAppeal, dates:(String, String), documentID:Int) {
        let appealServiceController = AppealServicesController.createAppeal(with: "appealServicesVC")
        
        let viewModel = AppealServiceViewModel.init(navigationController: self, services: services, dates: dates, documentID: documentID)
        appealServiceController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(appealServiceController, animated: true)
        
    }
    
    func seroprophylactics(sendModel:AppealServiceSend){
        let appealServiceController = SeroprophylacticsController.createAppeal(with: "seroprophyVC")
        
        let viewModel = SeroprohylacticsViewModel.init(navigationController: self, model: sendModel)
        appealServiceController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(appealServiceController, animated: true)
    }
    
    
    
}


//MARK: Создание полиса
extension HomeTabBarCoordinator:NewPoliceNavigation, ChooseInsuranceNavigation, InsuranceProgramNavigation, PaperInsurancNavigation, PaperInsurancInfoNavigation, PaperPoliceNavigation {
    
    func openCamera() {
        let cameraController = CameraController.createPolice(with: "cameraVC")
        
//        let viewModel = PaperPoliceViewModel.init(navigationController: self)
//        newPoliceController.viewModel = viewModel
        
        navigationController.pushViewController(cameraController, animated: true)
    }
    
    
    func createPaperPolice() {
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        self.navigationController.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
    
    func acceptInsuranse() {
        let newPoliceController = PaperPoliceController.createPolice(with: "newPaperPoliceVC")
        
        let viewModel = PaperPoliceViewModel.init(navigationController: self)
        newPoliceController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(newPoliceController, animated: true)
    }
    
    
    func chooseInsuranse() {
        let newPoliceController = PaperInsuranceInfoController.createPolice(with: "insInfoVC")
        
        let viewModel = PaperInsuranceInfoViewModel.init(navigationController: self)
        newPoliceController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(newPoliceController, animated: true)
    }
    
    func openInsuranceProgram(programs:[String]) {
        let newPoliceController = InsuranceProgramController.createPolice(with: "InsuranceProgramVC")
        
        let viewModel = InsuranceProgramViewModel.init(navigationController: self)
        viewModel.insuranceProgram = programs
        newPoliceController.viewModel = viewModel
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(newPoliceController, animated: true)
    }
    
    
    func openInsurance() {
        let newPoliceController = ChooseInsuranceController.createPolice(with: "chooseInsurance")
        newPoliceController.title = "Страховые компании"
        let viewModel = ChooseInsuranceViewModel.init(navigationController: self)
        newPoliceController.viewModel = viewModel
        navigationController.setNavigationBarHidden(false, animated: false)
    
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController.pushViewController(newPoliceController, animated: true)
    }
    
    func closeInsuranse(){
        let viewControllers: [UIViewController] = self.navigationController.viewControllers as [UIViewController]
        self.navigationController.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
   
}

extension HomeTabBarCoordinator: HistoryNavigation, DirectoryNavigation, ProfileNavigation{
    func logOut() {
        let parent = parentCoordinator as! AppCoordinator
        parent.goToAuth()
        parentCoordinator?.childDidFinish(self)
    }
    
    func chooseMO() {
        let parent = parentCoordinator as! AppCoordinator
        parent.goChooseMO()
        parentCoordinator?.childDidFinish(self)
    }
    
    
   
    
    
  
    
}
