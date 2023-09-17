//
//  Reactive+Extension.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

    var rxViewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }

}
