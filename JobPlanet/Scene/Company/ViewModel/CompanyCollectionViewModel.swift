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
     
    init() {
        getCellData()
    }
    
    func getCellData() {
        service.fetchCompanyData()
            .subscribe { cellData in
                self.cellData.accept(cellData.cellItems)
            }
            .disposed(by: disposeBag)
    }
    
    func getCompanyCellData() -> [CompanyCell] {
        return service.storedCompanyData
    }
    
    func getTotalCellData() -> [CellList] {
        return service.storedData
    }
}
