//
//  NetworkManager.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Alamofire

enum APIError: Error {
    case parseError
    case networkError
    case serverError
}

struct APIConstants {
    static let BASE_URL = "https://jpassets.jobplanet.co.kr/mobile-config"
    
    static let DYNAMIC_CELL_ITEMS = "/test_data_cell_items.json"
    static let RECRUITE_ITEMS = "/test_data_recruit_items.json"
}

final class NetworkManager<T: Decodable> {
    var fetchURL: String
    var method: HTTPMethod

    init(url: String, method: HTTPMethod) {
        self.fetchURL = APIConstants.BASE_URL + url
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
