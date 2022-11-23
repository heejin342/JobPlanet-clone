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
        let filtedData = recruiteViewModel.getTotalData()
            .filter { $0.title.contains(filterText ?? "") || $0.company.name.contains(filterText ?? "") }
        
        var filteredCompanies:[CellList] = []
        for company in companyViewViewModel.getCompanyCellData() {
            if company.name.contains(filterText ?? "")  {
                let companyCell = CellList.companyCell(company)
                filteredCompanies.append(companyCell)
            }
        }
        
        recruiteViewModel.recruitData.accept(filtedData)
        companyViewViewModel.cellData.accept(filteredCompanies)
    }
    
    mutating func resetFilter() {
        recruiteViewModel.recruitData.accept(self.recruiteViewModel.getTotalData())
        companyViewViewModel.cellData.accept(self.companyViewViewModel.getTotalCellData())
    }
    
    mutating func getRecruitdata() {
        recruiteViewModel.getRecruitdata()
    }
    
    mutating func getCompanydata() {
        companyViewViewModel.getCellData()
    }
}
