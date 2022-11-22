//
//  CompanyViewController+CollectionViewExtension.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit

extension CompanyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.cellData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        let data = viewModel.cellData.value[indexPath.row]
 
        if data.cellName == "CELL_TYPE_COMPANY" {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as? CompanyCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: data)
            return cell
        }
        
        if data.cellName == "CELL_TYPE_HORIZONTAL_THEME" {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontalCell", for: indexPath) as? HorizontalCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: data)
            cell.transitionDelegate = self.transitionDelagate
            return cell
        }
        
        if data.cellName == "CELL_TYPE_REVIEW" {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: data)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension CompanyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TabHeaderView", for: indexPath) as? TabHeaderView else { return UICollectionReusableView() }

        headerview.setTabButton(toggle: .company)
        headerview.buttonTapped = { [weak self] selectedTap in
            self?.transitionDelagate?.changeTab(tab: selectedTap)
        }
        
        return headerview
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: InsetVariables.tabHeaderHeight)
    }
}
