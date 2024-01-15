//
//  LoginSelectVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit
import PanModal
import Alamofire

class LoginSelectVC: UIViewController {
    var agree: AgreeVC?
    
    let kakaoLoginManager = KakaoLoginManagerImpl()
    let authRepository = AuthRepositoryImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func kakaoLogin(_ sender: Any) {
        kakaoLoginManager.excute(delegate: self)
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        AlertManager.show(message: "구글 로그인 미구현")
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        AlertManager.show(message: "애플 로그인 미구현")
    }
}

extension LoginSelectVC: KakaoLoginDelegate {
    func sendOAuthToken(_ token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .kakao, token: token)
            )
            
            if let currentSesison = LoginSessionManager.getLoginSession() {
                LogManager.log(messaeg: "기존 로그인되어있던 로그인 정보 \(currentSesison) 삭제")
            }
            
            LoginSessionManager.setLoginSession(accessToken: result.accessToken, refreshToken: result.refreshToken, type: .kakao)
            
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            
            if let result = meInfoResult.value {
                // 이미 닉네임이 있음 - 가입 완료 상태이므로 닉네임 설정화면 스킵
                LoginSessionManager.setNickname(nickname: result.nickname)
                LoginSessionManager.setState(state: .needJoinGroup)
            }
            
            let vc = AgreeVC()
            agree = vc
            vc.delegate = self
            
            presentPanModal(vc)
        }
    }
}

extension LoginSelectVC: AgreeDelegate {
    func agreeComplete() {
        agree?.dismiss(animated: true) { [weak self] in
            if let nickname = LoginSessionManager.getNickname() {
                let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
                let groupList = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
                LoginSessionManager.setState(state: .needJoinGroup)
                
                Task {
                    // 가입된 그룹 하나라도 있는지 체크
                    let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
                    if let result = result.value, result.contents.count > 0 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                        homeTabController.modalPresentationStyle = .fullScreen
                        self?.navigationController?.present(homeTabController, animated: true)
                        LoginSessionManager.setState(state: .login)
                    } else {
                        //가입한 그룹 하나도 없음
                        self?.navigationController?.pushViewController(groupList, animated: true)
                    }
                }
            } else {
                let nickNameVC = AgreeNicknameVC()
                self?.navigationController?.pushViewController(nickNameVC, animated: true)
            }
        }
    }
}
