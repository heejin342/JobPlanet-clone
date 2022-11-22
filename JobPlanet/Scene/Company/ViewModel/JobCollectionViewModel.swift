//
//  JobCollectionViewModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Foundation
import RxSwift
import RxRelay

class JobCollectionViewModel {

    let disposeBag = DisposeBag()
    var storeData: [CellList] = []
    
    var companyList: [CompanyCell] = []
    
    let cellData = BehaviorRelay<[CellList]>(value: [])
    
    
    init() {
        NetworkManager<CellItems>(url: APIConstants.DYNAMIC_CELL_ITEMS, method: .get).fetch { data in
            self.storeData = data.cellItems
            self.cellData.accept(data.cellItems)
        }
    }
    

}
