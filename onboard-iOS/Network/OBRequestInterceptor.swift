//
//  OBRequestInterceptor.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

import Alamofire

final class OBRequestInterceptor: RequestInterceptor {
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        
        var request = urlRequest
        
        // TODO: - 키체인, 소셜로그인 구현 후 삭제할 것
        let sugarToken = "77+9bVoF77+9ZjHvv71gDe+/vRNDKe+/vT1NZO+/"
        
        guard urlRequest.url?.absoluteString.hasPrefix(API.BASE_URL) == true else {
            completion(.success(urlRequest))
            return
        }
        
        request.setValue("Bearer " + sugarToken, forHTTPHeaderField: "Authorization")
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
