//
//  RecruitService.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/22.
//

import Foundation
import RxSwift

class RecruitService {
    
    let disposeBag = DisposeBag()
    var storedData: [RecruitList] = []
        
    func fetchRecruitData() -> Single<RecruitItems> {
        return Single.create { single in
            
            NetworkManager<RecruitItems>(url: APIConstants.RECRUITE_ITEMS, method: .get)
                .fetchWithRx()
                .subscribe(onNext: { data in
                    self.storedData = data.recruitItems
                    single(.success(data))
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create {}
        }
    }
}
