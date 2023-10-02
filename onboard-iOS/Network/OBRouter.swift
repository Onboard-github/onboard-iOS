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

    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }

    // MARK: - APIs

    case testAPI
    case auth(body: Body)

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        case .testAPI:
            return .get
        case .auth:
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
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        case .testAPI, .auth:
            return nil
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case .testAPI:
            return nil

        case let .auth(body):
            return body
        }
    }

    // MARK: - URL Request

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)
        request.method = method
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
