//
//  RecruitViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit
import Alamofire
import RxSwift
import SnapKit

class RecruitViewController: UIViewController {
    
    @IBOutlet var recruitCollectionView: UICollectionView!
    
    var viewModel: RecruitViewModel?
    let disposeBag = DisposeBag()
    
    var transitionDelegate: CellAction?

    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없어요!"
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeView()
        bindView()
    }
    
    func makeView() {
        recruitCollectionView.delegate = self
        recruitCollectionView.dataSource = self
        
        registerNib()
        addView()
    }
    
    func registerNib() {
        let nib = UINib(nibName: RecuitCollectionViewCell.Id, bundle: nil)
        recruitCollectionView.register(nib, forCellWithReuseIdentifier: RecuitCollectionViewCell.Id)
        recruitCollectionView.delegate = self
        recruitCollectionView.dataSource = self
        recruitCollectionView.isScrollEnabled = true
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        recruitCollectionView.collectionViewLayout = flowLayout
        recruitCollectionView.register(UINib(nibName: TabHeaderView.Id, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TabHeaderView.Id)
    }
    
    func addView() {
        recruitCollectionView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bindView() {
        viewModel?.recruitData
            .asDriver()
            .drive(onNext: { data in
                self.updateView(dataCount: data.count)
            })
            .disposed(by: disposeBag)
    }
    
    func updateView(dataCount: Int) {
        emptyLabel.isHidden = dataCount == 0 ? false : true
        self.recruitCollectionView.reloadData()
    }
}
    

extension RecruitViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewModel?.recruitData.value else {return 0}
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecuitCollectionViewCell.Id, for: indexPath) as? RecuitCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        guard let reqruitData = viewModel?.recruitData else {return UICollectionViewCell()}
        let data = reqruitData.value[indexPath.row]
        cell.configureCell(with: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let reqruitData = viewModel?.recruitData.value[indexPath.row] {
            self.transitionDelegate?.moveDetail(data: reqruitData)
        }
    }
}

extension RecruitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellW = (UIScreen.main.bounds.size.width - InsetVariables.mainInset * 2 - InsetVariables.cellLRInset) / 2
        let cellH = ( cellW / 160 * 98 ) + 128
        return CGSize(width: cellW, height: cellH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: InsetVariables.cellTBInset, left: InsetVariables.mainInset, bottom: .zero, right: InsetVariables.mainInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TabHeaderView.Id, for: indexPath) as? TabHeaderView else { return UICollectionReusableView() }
        
        headerview.setTabButton(toggle: .recruit)
        headerview.buttonTapped = { [weak self] selectedTab in
            self?.transitionDelegate?.changeTab(tab: selectedTab)
        }
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: InsetVariables.tabHeaderHeight)
    }
}
