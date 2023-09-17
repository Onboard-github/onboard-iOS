//
//  ViewController.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit

class ViewController: UIViewController {

    let useCase = TestUseCaseImpl(repository: TestRepositoryImpl())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        Task {
            let result = try await self.useCase.fetchTestAPi()

            print(result)
        }
    }
}

