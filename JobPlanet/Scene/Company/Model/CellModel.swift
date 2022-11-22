//
//  CellModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/18.
//

struct CellItems: Decodable {
    let cellItems: [CellList]
    
    enum CodingKeys: String, CodingKey {
        case cellItems = "cell_items"
    }
}

enum CellList: Decodable {
    case companyCell(CompanyCell)
    case horizontalCell(HorizontalCell)
    case reviewCell(ReviewCell)
    
    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
    }
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        let cellType = try keyedContainer.decode(String.self, forKey: .cellType)
        
        let container = try decoder.singleValueContainer()
        switch cellType {
        case "CELL_TYPE_COMPANY" : self = .companyCell(try container.decode(CompanyCell.self))
        case "CELL_TYPE_HORIZONTAL_THEME": self = .horizontalCell(try container.decode(HorizontalCell.self))
        case "CELL_TYPE_REVIEW": self = .reviewCell(try container.decode(ReviewCell.self))
        default: throw DecodingError.dataCorruptedError(forKey: .cellType, in: keyedContainer, debugDescription: "Unknown type")
        }
    }
}

extension CellList {
    var cellName: String {
        switch self {
        case .companyCell(_): return "CELL_TYPE_COMPANY"
        case .horizontalCell(_): return "CELL_TYPE_HORIZONTAL_THEME"
        case .reviewCell(_): return "CELL_TYPE_REVIEW"
        }
    }
    
    var cellData: AnyObject {
        switch self {
        case .companyCell(let a):
            return a as AnyObject
        case .horizontalCell(let b):
            return b as AnyObject
        case .reviewCell(let c):
            return c as AnyObject
        }
    }
}

struct CompanyCell: Decodable {
    let cellType: String
    let logoPath: String
    let name: String
    let industryName: String
    let rateTotalAvg: Double
    let reviewSummary: String
    let interviewQuestion: String
    let salaryAvg: Int
    let updateDate: String
    
    enum CodingKeys : String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name = "name"
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case interviewQuestion = "interview_question"
        case salaryAvg = "salary_avg"
        case updateDate = "update_date"
    }    
}

struct HorizontalCell: Decodable {
    let cellType: String
    let count: Int
    let sectionTitle: String
    let recommendRecruit: [RecruitList]
    
    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case count = "count"
        case sectionTitle = "section_title"
        case recommendRecruit = "recommend_recruit"
    }
}

struct ReviewCell: Decodable {
    let cellType: String
    let logoPath: String
    let name: String
    let industryName: String
    let rateTotalAvg: Double
    let reviewSummary: String
    let cons: String
    let pros: String
    let updateDate: String
    
    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name = "name"
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case cons = "cons"
        case pros = "pros"
        case updateDate = "update_date"
    }
}
