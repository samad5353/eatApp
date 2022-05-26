//
//  NetworkManager.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import Foundation
import Alamofire
import SwiftyBeaver

typealias Log = SwiftyBeaver

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // MARK: Headers
    func getAllHeaderValues() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        return headers
    }
    
    func makeAPI<T: Decodable>(urlString: String, method: HTTPMethod? = .post, params: [String: Any]? = nil, paramsCodable: Encodable? = nil, isBodyParamRequest: Bool = false, completion: @escaping (T?) -> Void) {
        let completeURL = APPURL.BaseURL + urlString
        Log.warning(completeURL)
        let headers: HTTPHeaders = self.getAllHeaderValues()
        AF.request(completeURL, method: method!, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                // check for errors
                switch response.result {
                case .success:
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: response.data!)
                        completion(obj)
                    } catch let jsonErr {
                        Log.error("Failed to decode json with error: \(jsonErr)")
                        completion(nil)
                    }
                case .failure:
                   completion(nil)
                }
            }
    }
}
