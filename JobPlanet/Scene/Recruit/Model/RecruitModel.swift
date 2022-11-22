//
//  RecruitModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

struct RecruitItems: Decodable {
    let recruitItems: [RecruitList]
    
    enum CodingKeys: String, CodingKey {
        case recruitItems = "recruit_items"
    }
}

struct RecruitList: Decodable {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String
    let imageUrl: String
    let company: CompanyDetail

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case reward = "reward"
        case appeal = "appeal"
        case imageUrl = "image_url"
        case company = "company"
    }
}

struct CompanyDetail: Decodable {
    let name: String
    let logoPath: String
    let ratings: [CompanyDetailRating]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case logoPath = "logo_path"
        case ratings = "ratings"
    }
}

struct CompanyDetailRating: Decodable {
    let type: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case rating = "rating"
    }
}
