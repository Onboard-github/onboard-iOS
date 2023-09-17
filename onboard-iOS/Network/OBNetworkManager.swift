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
}
