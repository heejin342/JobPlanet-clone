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
    
    let service = RecruitService()
    let disposeBag = DisposeBag()
    
    let recruitData = BehaviorRelay<[RecruitList]>(value: [])
    
    func getRecruitdata() {
        service.fetchRecruitData()
            .subscribe { recruitData in
                self.recruitData.accept(recruitData.recruitItems)
            }
            .disposed(by: disposeBag)
    }
    
    func getTotalData() -> [RecruitList] {
        return service.storedData
    }
}
