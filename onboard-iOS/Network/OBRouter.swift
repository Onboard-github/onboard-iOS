//
//  OBRouter.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import Alamofire

import ReactorKit

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
    
    // Auth
    case auth(body: Body)
    
    // Group
    case groupList(params: Params)
    case addGroup(body: Body)
    case setUser(body: Body)
    case gameList
    case createGroup(body: Body)
    
    // Group Image
    case pickerImage(params: Params)
    case randomImage
    
    // Game Result
    case gameResult(params: Params)

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        case .testAPI, .groupList, .gameList, .randomImage, .gameResult:
            return .get
        case .auth, .addGroup, .pickerImage, .createGroup:
            return .post
        case .setUser:
            return .put
        }
    }

    // MARK: - Path

    var path: String {
        switch self {
        case .testAPI:
            return "v1/test"
        case .auth:
            return "v1/auth/login"
        case .groupList, .addGroup:
            return "v1/group"
        case .setUser:
            return "v1/user/me"
        case .gameList:
            return "v1/group/0/game"
        case .pickerImage:
            return "v1/file"
        case .randomImage:
            return "api/v1/group/default-image"
        case .createGroup:
            return "api/v1/group"
        case .gameResult:
            return "api/v1/group/123/game"
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        case .testAPI, .auth, .addGroup, .groupList, .randomImage:
            return nil
        case .setUser, .gameList, .createGroup, .gameResult:
            return ["Authorization": "Bearer \(LoginSessionManager.getLoginSession()?.accessToken ?? "")"]
        case .pickerImage:
            return ["Authorization": "Bearer \(LoginSessionManager.getLoginSession()?.accessToken ?? "")",
                    "content-type": "multipart/form-data"]
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case .testAPI, .groupList, .gameList, .pickerImage, .randomImage, .gameResult:
            return nil

        case let .auth(body), let .addGroup(body), let .setUser(body), let .createGroup(body):
            return body
        }
    }
    
    // MARK: - Request Params
    
    var params: Params? {
        switch self {
        case .testAPI, .auth, .addGroup, .setUser, .gameList, .randomImage, .createGroup:
            return nil
        case let .groupList(params):
            return params
        case let .pickerImage(params):
            return params
        case let .gameResult(params):
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
