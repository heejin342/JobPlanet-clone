//
//  RecruitSectionTableViewCell.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/16.
//

import UIKit


class RecruitSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegatea: CellAction?
    var tempH: CGFloat = 0
    
    var recruitData: [RecruitList] = [] {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cvc")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true

        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: "TabHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TabHeaderView")
        
    }
    
    func updateView() {
        collectionView.reloadData()
    }
        
}
