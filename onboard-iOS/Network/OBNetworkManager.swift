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
    
    private let interceptor = OBRequestInterceptor()
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
        
        //        if let afError = response.error as? AFError {
        //            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
        //                print(dataString)
        //            }
        //        }

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
