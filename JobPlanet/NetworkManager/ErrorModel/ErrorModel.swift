//
//  ErrorModel.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/22.
//

enum APIError: Error {
    case decodingError
    case serverError
}

extension APIError {
    var errorMsg: String {
        switch self {
        case .decodingError: return "올바르지 않는 형식입니다. 관리자에게 문의해주세요"
        case .serverError: return "네트워크 오류가 발생했습니다. 잠시후 다시시도 해주세요"
        }
    }
}
