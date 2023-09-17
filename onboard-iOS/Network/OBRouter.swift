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

    // MARK: - HTTP Method

    var method: HTTPMethod {
        switch self {
        case .testAPI:
            return .get
        }
    }

    // MARK: - Path

    var path: String {
        switch self {
        case .testAPI:
            return "v1/test"
        }
    }

    // MARK: - Header

    var header: Header? {
        switch self {
        case .testAPI:
            return nil
        }
    }

    // MARK: - Request Body

    var body: Body? {
        switch self {
        case .testAPI:
            return nil
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
