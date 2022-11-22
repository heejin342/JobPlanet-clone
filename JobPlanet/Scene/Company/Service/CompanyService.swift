//
//  CompanyService.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/23.
//

import Foundation
import RxSwift

class CompanyService {
    let disposeBag = DisposeBag()
    var storedData: [CellList] = []
        
    func fetchRecruitData() -> Single<CellItems> {
        return Single.create { single in
            
            NetworkManager<CellItems>(url: APIConstants.DYNAMIC_CELL_ITEMS, method: .get)
                .fetchWithRx()
                .subscribe(onNext: { data in
                    self.storedData = data.cellItems
                    single(.success(data))
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create {}
        }
    }

}
