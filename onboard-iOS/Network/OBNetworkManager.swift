//
//  OBNetworkManager.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import Alamofire

final class OBNetworkManager {

    static let shared = OBNetworkManager()

    // MARK: - Request

    func asyncRequest<T: Decodable>(
        object: T.Type,
        router: OBRouter
    ) async throws -> DataResponse<T, AFError> {

        let response = await AF.request(router)
            .validate(statusCode: 200..<300)
            .serializingDecodable(object)
            .response

        return response
    }
    
    func googleLoginRequest(token: String) {
        let url = "\(API.BASE_URL)v1/auth/login"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "type": "GOOGLE_ID_TOKEN",
            "token": token
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<501)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response: \(value)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
