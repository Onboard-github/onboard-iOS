//
//  OBRouter.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import Alamofire

struct AccessToken {
    // 임시 토큰 (화면 연결 시 제거)
    static let token = "77+9bVoF77+9ZjHvv71gDe+/vRNDKe+/vT1NZO+/"
}

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
    case groupList(params: Params)
    case addGroup(body: Body)
    case pickerImage(params: Params)
    case randomImage

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        case .testAPI, .groupList, .randomImage:
            return .get
        case .auth, .addGroup, .pickerImage:
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
        case .groupList, .addGroup:
            return "v1/group"
        case .pickerImage:
            return "v1/file"
        case .randomImage:
            return "api/v1/group/default-image"
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        case .testAPI, .auth, .addGroup, .groupList, .randomImage:
            return nil
        case .pickerImage:
            return ["Authorization": "Bearer \(AccessToken.token)",
                    "content-type": "multipart/form-data"]
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case .testAPI, .groupList, .pickerImage, .randomImage:
            return nil

        case let .auth(body), let .addGroup(body):
            return body
        }
    }
    
    // MARK: - Request Params
    
    var params: Params? {
        switch self {
        case .testAPI, .auth, .addGroup, .randomImage:
            return nil
        case let .groupList(params):
            return params
        case let .pickerImage(params):
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
