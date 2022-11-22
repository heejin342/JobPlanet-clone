//
//  ViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/16.
//

import UIKit
import Alamofire

protocol CellAction {
    func changeTab(tab: TabButtonType?)
    func removeTab(_ tab: TabButtonType)
    func moveDetail(data: RecruitList)
}

protocol MakeChildScene {
    func makeRecruitTab()
    func makeCompanyTab()
    func addToMainView(with childView: UIViewController)
}

extension MainViewController: CellAction, MakeChildScene {}

class MainViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()

        viewModel.getRecruitdata()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.isFirstLoad {
            changeTab(tab: nil)
            viewModel.isFirstLoad = false
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
    
    
    /// CellAction protocol

    func changeTab(tab: TabButtonType?) {
        guard let tab = tab else {
            makeRecruitTab()
            return
        }
        
        switch tab {
        case .recruit:
            removeTab(.company)
            makeRecruitTab()
        case .company:
            removeTab(.recruit)
            makeCompanyTab()
        }
    }
    
    func removeTab(_ tab: TabButtonType) {
        switch tab {
        case .recruit:
            guard let vc = viewModel.recruiteView else {return}
            vc.willMove(toParent: nil)
            vc.removeFromParent()
            vc.view.removeFromSuperview()

        case .company:
            guard let vc = viewModel.companyView else {return}
            vc.willMove(toParent: nil)
            vc.removeFromParent()
            vc.view.removeFromSuperview()
        }
    }
    
    func moveDetail(data: RecruitList) {
        view.endEditing(true)
        guard let vc = instanceVC(name: RecruitDetailViewController.Id) as? RecruitDetailViewController else { return }
        vc.viewModel = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// MakeChildScene protocol

    func makeRecruitTab() {
        viewModel.recruiteView = instanceVC(name: RecruitViewController.Id) as? RecruitViewController
        viewModel.recruiteView?.viewModel = viewModel.recruiteViewModel        
        guard let recruiteView = viewModel.recruiteView else {return}
        recruiteView.transitionDelegate = self
        
        addToMainView(with: recruiteView)
    }
    
    func makeCompanyTab() {
        viewModel.companyView = instanceVC(name: CompanyViewController.Id) as? CompanyViewController
        viewModel.getCompanydata()
        
        viewModel.companyView?.viewModel = viewModel.companyViewViewModel
        guard let companyView = viewModel.companyView else {return}
        companyView.transitionDelagate = self

        addToMainView(with: companyView)
    }
    
    func addToMainView(with childView: UIViewController) {
        addChild(childView)
        let topAnchor = view.safeAreaInsets.top + InsetVariables.childViewTopInset
        let viewSize = view.frame.size
        childView.view.frame = CGRect(x: .zero, y: topAnchor, width: viewSize.width, height: viewSize.height - topAnchor)
        
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
}

extension MainViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == "" {
            viewModel.resetFilter()
        } else {
            viewModel.filter(filterText: searchBar.text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            viewModel.resetFilter()
        }
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
