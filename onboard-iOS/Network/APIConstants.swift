//
//  APIConstants.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation
import Alamofire

enum API {
    static let BASE_URL = "http://sandbox-api.onboardgame.co.kr/"
}

class APISession {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIEventLogger()
        return Session(configuration: configuration,
                       eventMonitors: [apiLogger])
    }()
}
