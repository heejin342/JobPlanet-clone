//
//  NetworkManager.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Alamofire
import RxSwift

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
                print(error.localizedDescription)
                print("네트워크 에러2: ", APIError.serverError.errorMsg)
            }
        }
    }
    
    func fetchWithRx() -> Observable<T> {
        return Observable.create { emitter in
            self.fetch() { result in
                emitter.onNext(result)
            }
            return Disposables.create()
        }
    }

}
