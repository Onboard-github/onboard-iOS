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
    case groupList(params: Params)
    case addGroup(body: Body)

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        case .testAPI, .groupList, .terms:
            return .get
        case .auth, .addGroup:
            return .post
        }
    }

    // MARK: - Path

    var path: String {
        switch self {
        case .testAPI:
            return "v1/test"
        case .auth:
            return "v1/auth/login"
        case .terms:
            return "api/v1/terms"
        case .groupList, .addGroup:
            return "v1/group"
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        case .testAPI, .auth, .addGroup, .groupList, .terms:
            return nil
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case .testAPI, .groupList, .terms:
            return nil

        case let .auth(body), let .addGroup(body):
            return body
        }
    }
    
    // MARK: - Request Params
    
    var params: Params? {
        switch self {
        case .testAPI, .auth, .addGroup, .terms:
            return nil
        case let .groupList(params):
            return params
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
