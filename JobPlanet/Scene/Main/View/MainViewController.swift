//
//  ViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/16.
//

import UIKit
import Alamofire

protocol CellAction {
    func changeTab(tab: Int?)
    func removeTab(tab: Int)
    func moveDetail(data: RecruitList)
}

class MainViewController: UIViewController, CellAction {
    
    @IBOutlet var searchBar: UISearchBar!
    let viewModel = MainViewModel()
    
    var recruiteView: RecruitViewController?
    var recruiteViewModel = RecruitViewModel()
    
    var companyView: CompanyViewController?
    var companyViewViewModel = JobCollectionViewModel()

    var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLoad {
            changeTab(tab: nil)
            isFirstLoad = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setSearchBar() {
        searchBar.delegate = self
        searchBar.setImage(UIImage(named: "logoSearch"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.backgroundImage = UIImage()
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.JobPlanet.gray2])
            textfield.textColor = UIColor.JobPlanet.gray1
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    func changeTab(tab: Int?) {
        guard let tab = tab else {
            makeRecruitTab()
            return
        }
        
        if tab == 0 {
            removeTab(tab: 1)
            makeRecruitTab()
        } else {
            removeTab(tab: 0)
            makeCompanyTab()
        }
    }
    
    func removeTab(tab: Int) {
        if tab == 0 {
            guard let vc = recruiteView else {return}
            vc.willMove(toParent: nil)
            vc.removeFromParent()
            vc.view.removeFromSuperview()
        }
        
        if tab == 1 {
            guard let vc = companyView else {return}
            vc.willMove(toParent: nil)
            vc.removeFromParent()
            vc.view.removeFromSuperview()
        }
    }
    
    func moveDetail(data: RecruitList) {
        view.endEditing(true)

        guard let vc = instanceVC(name: RecruitDetailViewController.Id) as? RecruitDetailViewController else { return }
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func makeRecruitTab() {
        recruiteView = instanceVC(name: "RecruitViewController") as? RecruitViewController
        recruiteView?.viewModel = recruiteViewModel
        guard let recruiteView = recruiteView else {return}
        recruiteView.transitionDelegate = self
        
        addChild(recruiteView)
        let topAnchor = view.safeAreaInsets.top + 52
        recruiteView.view.frame = CGRect(x: 0, y: topAnchor, width: view.frame.size.width, height: view.frame.size.height - topAnchor)
        view.addSubview(recruiteView.view)
        recruiteView.didMove(toParent: self)
    }
    
    func makeCompanyTab() {
        companyView = instanceVC(name: "CompanyViewController") as? CompanyViewController
        companyView?.viewModel = companyViewViewModel
        guard let companyView = companyView else {return}
        companyView.transitionDelagate = self
        
        addChild(companyView)
        let topAnchor = view.safeAreaInsets.top + 52
        companyView.view.frame = CGRect(x: 0, y: topAnchor, width: view.frame.size.width, height: view.frame.size.height - topAnchor)
        view.addSubview(companyView.view)
        companyView.didMove(toParent: self)
    }
    
    func filterData(_ filterText: String?) {
        let filtedData = recruiteViewModel.storeData
            .filter { $0.title.contains(filterText ?? "") ||  $0.company.name.contains(filterText ?? "") }
        
        recruiteViewModel.reqruitData.accept(filtedData)
    }
        
}

extension MainViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == "" {
            recruiteViewModel.reqruitData.accept(recruiteViewModel.storeData)
        } else {
            filterData(searchBar.text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            recruiteViewModel.reqruitData.accept(recruiteViewModel.storeData)
        }
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
