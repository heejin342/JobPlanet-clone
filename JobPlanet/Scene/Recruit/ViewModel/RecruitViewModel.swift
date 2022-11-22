//
//  RecruitViewModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Foundation
import RxSwift
import RxRelay

class RecruitViewModel {
    let disposeBag = DisposeBag()
    var storeData: [RecruitList] = []
    
    let recruitData = BehaviorRelay<[RecruitList]>(value: [])
    
    init() {
        NetworkManager<RecruitItems>(url: APIConstants.RECRUITE_ITEMS, method: .get).fetch { data in
            self.storeData = data.recruitItems
            self.recruitData.accept(data.recruitItems)
        }
    }
}
