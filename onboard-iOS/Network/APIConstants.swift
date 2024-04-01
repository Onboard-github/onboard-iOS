//
//  APIConstants.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation
import Alamofire

enum API {
    static let BASE_URL = "http://api.onboardgame.co.kr/"
}

enum GifURL {
    static let url = "https://s3-alpha-sig.figma.com/img/fcdf/0f6f/658ee1272b9aff5a07773dd72a4d4354?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kpaFuMrbWxgO9GNK51hf9mdXafjIKTGDEuY7jFaT4~Js6-Xw75X4uZPknV9Zr4sz~FBo-I2M0OJFuq5IxsCkoKkdOY8c3CNqb6TQHU0G36n5Eqnvc8DFTWXTIru0-USU6nM4XwMABByjTeUdAW~e8t9epGkhC0LmmfB4u8QzrjeqZSOoYMLPP8Wgh2l-sYh4Abwbb~~p5FETqoI0TPxI0NXx1zIg7xhT6dBqd0eLgNmAqsV3QCQg49YcDM5jafkqvPRmkFTYk8aod8aXI119mzAS~3r~DazbGDarvh7jZaHKVjwaTENP5ef~7CRW91Sbf4uK4VMPkTfpqm9B24VFug__"
}

class APISession {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIEventLogger()
        return Session(configuration: configuration,
                       eventMonitors: [apiLogger])
    }()
}
