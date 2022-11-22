//
//  RecruitSectionTableView+Extension.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit

extension RecruitSectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recruitData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvc", for: indexPath) as? CollectionViewCell else{
            return UICollectionViewCell()
        }
        
        let data = recruitData[indexPath.row]
        cell.configureCell(with: data) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = recruitData[indexPath.row]
        self.delegatea?.moveDetail(data: data)
    }
}

extension RecruitSectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellW = (UIScreen.main.bounds.size.width - 40 - 15) / 2
        let cellH = ( cellW / 160 * 98 ) + 128
        
        return CGSize(width: cellW, height: cellH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TabHeaderView", for: indexPath) as? TabHeaderView else { return UICollectionReusableView() }
        
        headerview.setTabButton(toggle: .recruit)

        headerview.buttonTapped = { [weak self] selectedTab in
            self?.delegatea?.changeTab(tab: selectedTab)
        }
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 62)
    }
}
