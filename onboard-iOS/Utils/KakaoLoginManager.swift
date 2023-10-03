//
//  KakaoLoginManager.swift
//  onboard-iOS
//
//  Created by main on 2023/10/03.
//

import Foundation

protocol KakaoLoginManager {
    func excute(delegate: KakaoLoginDelegate)
}

final class KakaoLoginManagerImpl: NSObject, KakaoLoginManager {

    private var token: String = "" {
        didSet {
            self.delegate?.sendOAuthToken(self.token)
        }
    }

    weak var delegate: KakaoLoginDelegate?

    func excute(delegate: KakaoLoginDelegate) {
        self.delegate = delegate
        print("kakao login button hit")
    }
}
