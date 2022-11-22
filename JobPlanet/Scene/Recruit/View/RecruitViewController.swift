//
//  RecruitViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit
import Alamofire
import RxSwift

class RecruitViewController: UIViewController {
    
    @IBOutlet var recruiteTableView: UITableView!
    var viewModel: RecruitViewModel?
    let disposeBag = DisposeBag()
    
    var transitionDelegate: CellAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeView()
        bindView()
    }
    
    func makeView() {
        recruiteTableView.delegate = self
        recruiteTableView.dataSource = self
        
        registerNib()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "RecruitSectionTableViewCell", bundle: nil)
        recruiteTableView.register(nib, forCellReuseIdentifier: "RecruitSectionTableViewCell")
        recruiteTableView.isScrollEnabled = false
    }
    
    func bindView() {
        viewModel?.reqruitData
            .asDriver()
            .drive(onNext: {_ in
                self.updateView()
            })
            .disposed(by: disposeBag)
    }
    
    func updateView() {
        self.recruiteTableView.reloadData()
    }
}
    

extension RecruitViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecruitSectionTableViewCell") as? RecruitSectionTableViewCell else {return UITableViewCell()}
        cell.delegatea = self.transitionDelegate
        cell.recruitData = (viewModel?.reqruitData.value)!
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
}
