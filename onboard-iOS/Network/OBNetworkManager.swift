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
        
        //        if let afError = response.error as? AFError {
        //            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
        //                print(dataString)
        //            }
        //        }

        return response
    }
    
    func asyncFileUploadRequest<T: Decodable>(
        object: T.Type,
        router: OBRouter,
        file: File
    ) async throws -> DataResponse<T, AFError> {
        
        let response = await AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(file.data, 
                                     withName: "file",
                                     fileName: file.name,
                                     mimeType: file.mimeType)
            for (key, value) in router.params ?? [:] {
                if let data = "\(value)".data(using: .utf8) {
                    MultipartFormData.append(data, withName: key)
                }
            }
        }, with: router)

            .validate(statusCode: 200..<300)
            .serializingDecodable(object)
            .response
        
        return response
    }
    
    func googleLoginRequest(token: String) throws {
        let googleLoginAPI = try OBRouter.auth(
            body: AuthRequest.Body(
                type: AuthEntity.Req.AuthType.google.rawValue,
                token: token
            ).encode()
        )

        APISession.session.request(googleLoginAPI)
            .responseDecodable { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success(let data):
                    print("Response Data: \(data)")
                case .failure(let error):
                    print("Response Error: \(error)")
                }
            }
    }
}
