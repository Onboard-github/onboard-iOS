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

enum GifURL {
    static let url = "https://s3-alpha-sig.figma.com/img/158b/4197/dd2bc4fe7471b517be67f13ba9f178a2?Expires=1708300800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bS~gZt1umch5MDpVqUtFABZKB5Jf7r8UlrGcTFbbTvsiF-1eQAWmDNV0Hde9c-jGsLwMHWU2GST8jJJ4n~6ldOeUTekAno5CCNXEQB9fGxjOJs15DwCSRFv8lGbHJkSFE7Yzs9cuxVSWuYOdM~nPXi7VkYE8vwXRbNMaih7Dndb-eRMWghNCJklW3AW-fpgqP1MvF-KE0Aj-kldv4iY0QhvDL3JNZdwQoFEr60Gq9KJq0ccf66tMqXidzrtE~SIkideVTnXgSfiC3Mac9Gc2olDdVKbnwnllfG~W5z3zv31Jb-y~2dW0Bu-4a0yAKkprV-z8LI5I1aUmGgqFVYE3KA__"
}

class APISession {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIEventLogger()
        return Session(configuration: configuration,
                       eventMonitors: [apiLogger])
    }()
}
