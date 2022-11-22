//
//  NetworkManager.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Alamofire

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

final class NetworkManager<T: Decodable> {
    var fetchURL: String
    var method: HTTPMethod

    init(url: String, method: HTTPMethod) {
        self.fetchURL = JobPlanetKey.BASE_URL + url
        self.method = method
    }
    
    func fetch(completion: @escaping (T) -> Void) {
        AF.request(self.fetchURL,
                   method: self.method,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("네트워크 에러2: ", error.localizedDescription)
            }
        }
    }
}
