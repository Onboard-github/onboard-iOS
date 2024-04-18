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
    
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    let kakaoLoginManager = KakaoLoginManagerImpl()
    let appleLoginManager = AppleLoginManagerImpl()
    let googleLoginManager = GoogleLoginManagerImpl()
    let authRepository = AuthRepositoryImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        self.configureButton()
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        kakaoLoginManager.excute(delegate: self)
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        googleLoginManager.excute(presentingViewController: self,
                                  delegate: self)
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        appleLoginManager.excute(delegate: self)
    }
    
    private func acceptTokenHandler(authEntity: AuthEntity.Res, type: UserLoginSessionType) {
        Task {
            if let currentSesison = LoginSessionManager.getLoginSession() {
                LogManager.log(messaeg: "기존 로그인되어있던 로그인 정보 \(currentSesison) 삭제")
            }
            
            LoginSessionManager.setLoginSession(accessToken: authEntity.accessToken, refreshToken: authEntity.refreshToken, type: type)
            
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            
            if let result = meInfoResult.value {
                // 이미 닉네임이 있음 - 가입 완료 상태이므로 닉네임 설정화면 스킵
                self.appleLoginManager.delegate?.userName(nickname: result.nickname)
                LoginSessionManager.setNickname(nickname: result.nickname)
                LoginSessionManager.setState(state: .needJoinGroup)
            }
            
            let vc = AgreeVC()
            agree = vc
            vc.delegate = self
            
            presentPanModal(vc)
        }
    }
    
    private func configureButton() {
        self.kakaoLoginButton.setTitleColor(Colors.Gray_14, for: .normal)
        self.kakaoLoginButton.titleLabel?.font = Font.Typography.body3_M
        
        self.googleLoginButton.setTitleColor(Colors.Gray_9, for: .normal)
        self.googleLoginButton.titleLabel?.font = Font.Typography.body3_M
        
        self.appleLoginButton.setTitleColor(Colors.Gray_1, for: .normal)
        self.appleLoginButton.titleLabel?.font = Font.Typography.body3_M
    }
}

extension LoginSelectVC: AgreeDelegate {
    func agreeComplete() {
        agree?.dismiss(animated: true) { [weak self] in
            if LoginSessionManager.getNickname() != nil {
                let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
                let groupList = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
                LoginSessionManager.setState(state: .needJoinGroup)
                
                Task {
                    // 가입된 그룹 하나라도 있는지 체크
                    let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
                    //                    if let result = result.value, result.contents.count > 0 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                    homeTabController.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(homeTabController, animated: true)
                    LoginSessionManager.setState(state: .login)
                    //                    } else {
                    //                        //가입한 그룹 하나도 없음
                    //                        self?.navigationController?.pushViewController(groupList, animated: true)
                    //                    }
                }
            } else {
                if let _ = self?.appleLoginManager {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                    homeTabController.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(homeTabController, animated: true)
                } else {
                    let nickNameVC = AgreeNicknameVC()
                    self?.navigationController?.pushViewController(nickNameVC, animated: true)
                }
            }
        }
    }
}

extension LoginSelectVC: KakaoLoginDelegate {
    func sendOAuthToken(_ token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .kakao, token: token)
            )
            
            acceptTokenHandler(authEntity: result, type: .kakao)
        }
    }
}

extension LoginSelectVC: AppleLoginDelegate {
    func success(token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .apple, token: token)
            )
            
            acceptTokenHandler(authEntity: result, type: .apple)
        }
    }
    
    func userName(nickname: String) {
        Task {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: Empty.self,
                    router: .setUser(
                        body: ["nickname": nickname ]
                    )
                )
            if result.response?.statusCode == 200 {
                LoginSessionManager.setNickname(nickname: nickname)
                LoginSessionManager.setState(state: .login)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                homeTabController.modalPresentationStyle = .fullScreen
                navigationController?.present(homeTabController, animated: true)
            }
        }
    }
}

extension LoginSelectVC: GoogleLoginDelegate {
    func loginSuccess(token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .google, token: token)
            )
            
            acceptTokenHandler(authEntity: result, type: .google)
        }
    }
}
