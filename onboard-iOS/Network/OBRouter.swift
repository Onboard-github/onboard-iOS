//
//  OBRouter.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import Alamofire

enum OBRouter: URLRequestConvertible {

    // MARK: - Properties

    typealias Header = [String: Any]
    typealias Body = [String: Any]
    typealias Params = [String: Any]

    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }

    // MARK: - APIs

    case testAPI
    case auth(body: Body)
    case terms
    case agreementTerms(body: Body)
    case onboarding
    case groupList(params: Params)
    case addGroup(body: Body)

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        // Group
        case .groupList, .addGroup:
            return .get
            
        // Match
            
        // Terms
        case .terms:
            return .get
            
        case .agreementTerms:
            return .post
            
        // Auth
        case .auth:
            return .post
            
        // Setting
            
        // User
        case .onboarding:
            return .get
            
        // Game
            
        // Member
        
        // Etc
        case .testAPI:
            return .get
            
        }
    }

    // MARK: - Path

    var path: String {
        switch self {
            // Group
            case .groupList, .addGroup:
                return "v1/group"
                
            // Match
                
            // Terms
            case .terms, .agreementTerms:
                return "v1/terms"
                
            // Auth
            case .auth:
                return "v1/auth/login"
                
            // Setting
                
            // User
            case .onboarding:
                return "v1/user/me/onboarding"
                
            // Game
                
            // Member
            
            // Etc
            case .testAPI:
                return "v1/test"
            
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case let .auth(body), 
             let .agreementTerms(body),
             let .addGroup(body):
            return body
            
        default:
            return nil
        }
    }
    
    // MARK: - Request Params
    
    var params: Params? {
        switch self {
        case let .groupList(params):
            return params
        default:
            return nil
        }
    }

    // MARK: - URL Request

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)
        request.method = method
        
        header?.forEach({ element in
            request.setValue("\(element.value)", forHTTPHeaderField: element.key)
        })
        
        params?.forEach({ element in
            request.url?.append(queryItems: [URLQueryItem(name: element.key, value: "\(element.value)")])
        })
        
        request = try JSONEncoding.default.encode(
            request,
            with: body
        )
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        return request
    }
}
