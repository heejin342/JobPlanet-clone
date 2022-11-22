//
//  CompanyCollectionViewModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Foundation
import RxSwift
import RxRelay

class CompanyCollectionViewModel {
 
    let service = CompanyService()
    let disposeBag = DisposeBag()
    
    let cellData = BehaviorRelay<[CellList]>(value: [])
        
    func getCellData() {
        service.fetchRecruitData()
            .subscribe { cellData in
                self.cellData.accept(cellData.cellItems)
            }
            .disposed(by: disposeBag)
    }
    

}
