//
//  CompanyViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/19.
//

import UIKit
import RxSwift
import RxCocoa

class CompanyViewController: UIViewController {

    @IBOutlet var jobCollectionView: UICollectionView!

    var viewModel: CompanyCollectionViewModel?
    let disposeBag = DisposeBag()
    
    var transitionDelagate: CellAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeView()
    }
    
    func bindView() {
        viewModel?.cellData
            .asDriver()
            .drive(onNext: {_ in
                self.updateView()
            })
            .disposed(by: disposeBag)
    }
    
    func updateView() {
        self.jobCollectionView.reloadData()
    }
    
    func makeView() {
        guard let jobCollectionView = jobCollectionView else { return }
        jobCollectionView.delegate = self
        jobCollectionView.dataSource = self
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        jobCollectionView.collectionViewLayout = flowLayout

        registerNib()
    }
    
    func registerNib() {
        let companyNib = UINib(nibName: CompanyCollectionViewCell.Id, bundle: nil)
        jobCollectionView.register(companyNib, forCellWithReuseIdentifier: "companyCell")
        
        let horizontalNib = UINib(nibName: HorizontalCollectionViewCell.Id, bundle: nil)
        jobCollectionView.register(horizontalNib, forCellWithReuseIdentifier: "horizontalCell")

        let reviewNib = UINib(nibName: ReviewCollectionViewCell.Id, bundle: nil)
        jobCollectionView.register(reviewNib, forCellWithReuseIdentifier: "reviewCell")
                
        let headerNib = UINib(nibName: TabHeaderView.Id, bundle: nil)
        jobCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TabHeaderView.Id)
    }    
}

