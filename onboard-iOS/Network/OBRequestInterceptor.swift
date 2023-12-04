//
//  OBRequestInterceptor.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

import Alamofire

final class OBRequestInterceptor: RequestInterceptor {
    
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        
        var request = urlRequest
        
        guard urlRequest.url?.absoluteString.hasPrefix(API.BASE_URL) == true,
              let accessToken = self.keychainService.value(forKey: .accessToken) else {
            completion(.success(urlRequest))
            return
        }
        
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        // refresh token 인증 로직
        
    }
}
