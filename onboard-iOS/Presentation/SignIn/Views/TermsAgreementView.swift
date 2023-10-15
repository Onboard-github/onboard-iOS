//
//  TermsAgreementView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/10.
//

import UIKit

import SnapKit

final class TermsAgreementView: UIView {

    // MARK: - Metric

    private enum Metric {
        static let modalTop: CGFloat = 338
        static let screenHeight: CGFloat = UIDevice.current.heightOfSafeArea(includeBottomInset: true)
    }

    // MARK: - UI

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()

    private let modalView = TermsAgreementModalView()

    // MARK: - Properties

    private var modalHeight = Metric.screenHeight - Metric.modalTop

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(termsList: [String]) {
        self.modalView.bind(termsList: termsList)
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white

        self.modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.modalView.layer.cornerRadius = 16
        self.modalView.clipsToBounds = true

        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(self.dimmedView)
        self.addSubview(self.modalView)

        self.dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.modalView.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func showBottomSheet() {

      self.modalView.snp.updateConstraints {
          $0.top.equalToSuperview().offset(self.modalHeight)
      }

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.dimmedView.alpha = 0.5
                self.layoutIfNeeded()
            }, completion: nil
        )
    }

    func hideBottomSheet(view: UIViewController) {
        self.modalView.snp.updateConstraints {
            $0.top.equalToSuperview().offset(Metric.screenHeight)
        }

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.dimmedView.alpha = 0.0
                self.layoutIfNeeded()
            }) { _ in
                if view.presentingViewController != nil {
                    view.dismiss(animated: false, completion: nil)
                }
            }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = TermsAgreementView()
            view.bind(termsList: ["서비스 이용약관", "개인정보 처리방침"])

            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
