//
//  RankVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit
import Alamofire

class RankVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameList()
    }
    
    private func gameList() {
        Task {
            do {
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: GamgeList.self,
                        router: OBRouter.gameList
                    )
                
                guard let data = result.value else {
                    throw NetworkError.noExist
                }
                
                if result.response?.statusCode == 200 {
                    print(result.value)
                } else {
                    AlertManager.show(message: "응답이 200이 아님 \(result.response?.statusCode)")
                }
                
            } catch {
                AlertManager.show(message: error.localizedDescription)
                throw error
            }
        }
    }
}
