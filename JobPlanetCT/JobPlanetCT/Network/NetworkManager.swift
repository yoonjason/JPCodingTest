//
//  NetworkManager.swift
//  dodoPoint
//
//  Created by yoon on 2021/05/12.
//

import Foundation
import Alamofire

public class NetworkConfig {
    var baseURL: String = ""
    var isRequest: Bool = true
}

enum JPResult<T> {
    case success(T)
    case failure(Error)
}

public class NetworkManager {
    static var shared = NetworkManager()



    var config: NetworkConfig {
        let config = NetworkConfig()
        let baseURL = "https://jpassets.jobplanet.co.kr/mobile-config/test_data.json"
        config.baseURL = baseURL
        config.isRequest = true
        return config
    }


    func baseRequest(method: HTTPMethod, parameters: Parameters?, completed: @escaping (AFResult<Any>) -> Void) {
        let url = config.baseURL
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        print(url)
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: header).validate().responseJSON { (responseData) in
            completed(responseData.result)
        }
    }

    func requestPost(_ parameters: Parameters?, completed: @escaping (JPResult<Any>) -> Void) {
        baseRequest(method: .get, parameters: parameters) { (result) in

            switch (result) {
            case let .failure(error):
                completed(JPResult<Any>.failure(error))
                print(error.errorDescription)
            case let .success(value):
                completed(JPResult<Any>.success(value))
            }

        }


    }

}
