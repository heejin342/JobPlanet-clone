//
//  MainViewModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/22.
//

import Foundation

struct MainViewModel {
    
    var recruiteView: RecruitViewController?
    lazy var recruiteViewModel = RecruitViewModel()
    
    var companyView: CompanyViewController?
    lazy var companyViewViewModel = CompanyCollectionViewModel()

    var isFirstLoad = true
    
    mutating func filter(filterText: String?) {
        let filtedData = recruiteViewModel.storeData
            .filter { $0.title.contains(filterText ?? "") ||  $0.company.name.contains(filterText ?? "") }
        
        recruiteViewModel.recruitData.accept(filtedData)
    }
    
    mutating func resetFilter() {
        recruiteViewModel.recruitData.accept(self.recruiteViewModel.storeData)
    }
}
