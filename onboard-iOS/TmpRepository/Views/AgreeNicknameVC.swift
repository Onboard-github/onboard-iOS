//
//  AgreeNicknameVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit

class AgreeNicknameVC: UIViewController {
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var confirmButton: BorderedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameField.delegate = self
    }
    
    class Empty: Codable {}
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        Task {
            do {
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: Empty.self,
                        router: OBRouter.setUser(
                            body: ["nickname": nickNameField.text ?? ""]
                        )
                    )
                
                guard let data = result.value else {
                    throw NetworkError.noExist
                }
                
                if result.response?.statusCode == 200 {
//                    navigationController?.popViewController(animated: true)
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
//                    homeTabController.modalPresentationStyle = .fullScreen
//                    navigationController?.present(homeTabController, animated: true) { [weak self] in
//                        LoginSessionManager.setNickname(nickname: self?.nickNameField.text ?? "")
//                    }
                    let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
                    let groupList = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
                    LoginSessionManager.setNickname(nickname: nickNameField.text ?? "")
                    navigationController?.pushViewController(groupList, animated: true)
                } else {
                    AlertManager.show(message: "응답이 200이 아님 \(result.response?.statusCode)")
                }
                
            } catch {
                AlertManager.show(message: error.localizedDescription)
                throw error
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension AgreeNicknameVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 최대 글자 수를 설정합니다.
        let maxLength = 10
        
        // 입력된 글자 수를 계산합니다.
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 최대 글자 수를 초과하는지 확인하고 초과한다면 입력을 허용하지 않습니다.
        return newText.count <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        maxLabel.text = "\(textField.text?.count ?? 0)/10"
        //            print("현재 글자 수: \(textField.text?.count ?? 0)")
        if textField.text?.count == 0 {
            confirmButton.isEnabled = false
        } else {
            confirmButton.isEnabled = true
        }
    }
}
