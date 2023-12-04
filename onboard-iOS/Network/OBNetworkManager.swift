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
    
    private var session: Session
    
    private let interceptor = OBRequestInterceptor(
        keychainService: KeychainServiceImpl()
    )
    private let apiLogger = APIEventLogger()
    
    private init() {
        self.session = Session(
            interceptor: self.interceptor,
            eventMonitors: [apiLogger]
        )
    }

    // MARK: - Request

    func asyncRequest<T: Decodable>(
        object: T.Type,
        router: OBRouter
    ) async throws -> DataResponse<T, AFError> {

        let response = await session
            .request(router)
            .validate(statusCode: 200..<300)
            .serializingDecodable(object)
            .response

        return response
    }
}
