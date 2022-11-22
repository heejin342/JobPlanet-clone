//
//  HorizontalCollectionViewCell.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet var horizontalCompanyCollectionVIew: UICollectionView!
    
    var companyData: HorizontalCell? {
        didSet {
            updateView()
        }
    }
    
    var transitionDelegate: CellAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: RecuitCollectionViewCell.Id, bundle: nil)
        horizontalCompanyCollectionVIew.register(nib, forCellWithReuseIdentifier: RecuitCollectionViewCell.Id)
        
        horizontalCompanyCollectionVIew.delegate = self
        horizontalCompanyCollectionVIew.dataSource = self
        horizontalCompanyCollectionVIew.isScrollEnabled = true
        horizontalCompanyCollectionVIew.showsHorizontalScrollIndicator = false
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        horizontalCompanyCollectionVIew.collectionViewLayout = flowLayout
    }

    
    func configureCell(with data: CellList) {
        guard let data = data.cellData as? HorizontalCell else { return }
        companyData = data
     }
    
    func updateView() {
        horizontalCompanyCollectionVIew.reloadData()
    }
    
}

extension HorizontalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyData?.recommendRecruit.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecuitCollectionViewCell.Id, for: indexPath) as? RecuitCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        guard let data = companyData?.recommendRecruit[indexPath.row] else {return UICollectionViewCell()}
        cell.configureCell(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = companyData?.recommendRecruit[indexPath.row] {
            transitionDelegate?.moveDetail(data: data)
        }
    }
}

extension HorizontalCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellW = (UIScreen.main.bounds.size.width - 40 - 15) / 2
        let cellH = ( cellW / 160 * 98 ) + 128
        
        return CGSize(width: cellW, height: cellH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



