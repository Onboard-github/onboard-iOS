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
        
        if let afError = response.error as? AFError {
            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                print("네트워크 애러: \(dataString)")
                if dataString.contains("Auth004"), dataString.contains("로그인이 필요합니다.") {
                    print("로그아웃 됨 (또는 토큰만료)")
                    LoginSessionManager.logout()
                    exit(0)
                }
            }
        }

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
}
