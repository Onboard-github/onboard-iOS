//
//  TermsView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/27.
//

import UIKit

import SnapKit

final class TermsView: UIView {

    // MARK: - Metric

    private enum Metric {
        static let topMargin: CGFloat = 16
        static let widthInset: CGFloat = 28
    }

    // MARK: - UI

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let contentLabel = UILabel()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(text: String) {
        self.contentLabel.setAttributed(
            lineHeight: 20,
            letterSpacing: -0.4,
            text: text
        )
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white

        self.stackView.axis = .vertical
        self.stackView.alignment = .center
        
        self.contentLabel.numberOfLines = 0
        self.contentLabel.font = UIFont(name: "SpoqaHanSansNeo-Normal", size: 14)
        self.contentLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)

        self.stackView.addArrangedSubview(self.contentLabel)

        self.scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        self.stackView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(Metric.widthInset)
            $0.leading.trailing.equalToSuperview().inset(Metric.widthInset)
            $0.top.bottom.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = TermsView()

            view.bind(text: """
무성할 멀리 딴은 별에도 헤는 있습니다. 이름과, 별빛이 내린 차 시인의 계절이 별 하나의 소학교 까닭입니다. 까닭이요, 나는 벌레는 못 까닭이요, 하나에 봅니다. 하나에 아이들의 쓸쓸함과 불러 멀듯이, 별 없이 시와 별 버리었습니다. 별 밤이 비둘기, 있습니다. 하늘에는 멀리 책상을 별 남은 새워 별들을 언덕 버리었습니다. 벌레는 딴은 너무나 계십니다. 않은 까닭이요, 가을로 밤을 풀이 같이 헤일 파란 시와 까닭입니다.

패, 오면 무성할 이런 이름과 프랑시스 버리었습니다. 다 사랑과 계절이 어머니, 어머니, 마리아 벌써 듯합니다.시인의 헤일 어머니 겨울이 이름자를 프랑시스 봅니다. 내린 시인의 책상을 위에 봅니다. 그리고 이웃 별 거외다.

위에 봄이 이름을 애기 위에 어머니, 이 까닭입니다. 사랑과 경, 노새, 까닭입니다. 까닭이요, 벌써 라이너 강아지, 프랑시스 이름과, 불러 별 봅니다. 하나 가을로 하나의 그러나 아침이 아직 거외다. 나는 파란 어머니, 까닭입니다. 둘 지나고 위에 마리아 소녀들의 밤을 헤일 나의 이네들은 있습니다. 별을 불러 무성할 소학교 까닭입니다. 흙으로 같이 위에 이름과, 하나에 아침이 봅니다.않은 프랑시스 소학교 동경과 까닭입니다. 오는 어머님, 내 가을 애기 노루, 까닭입니다. 옥 비둘기, 아무 거외다.

애기 아스라히 멀리 하늘에는 이름을 자랑처럼 별에도 별 별이 까닭입니다. 아이들의 별 추억과 파란 덮어 동경과 하나에 했던 밤을 버리었습니다. 딴은 하나에 릴케 이국 듯합니다. 새워 애기 어머님, 같이 별 풀이 하나에 버리었습니다. 이국 나는 위에도 라이너 잠, 된 어머니 때 까닭입니다. 아무 오면 마리아 별빛이 거외다. 지나고 하나 당신은 거외다. 별 이름과, 계절이 그러나 까닭이요, 봅니다. 이너 강아지, 프랑시스 이름과, 불러 별 봅니다. 하나 가을로 하나의 그러나 아침이 아직 거외다. 나는 파란 어머니, 까닭입니다. 둘 지나고 위에 마리아 소녀들의 밤을 헤일 나의 이네들은 있습니다. 별을 불러 무성할 소학교 까닭입니다. 흙으로 같이 위에 이름과, 하나에 아침이 봅니다.않은 프랑시스 소학교 동경과 까닭입니다. 오는 어머님, 내 가을 애기 노루, 까닭입니다. 옥 비둘기, 아무 거외다. 애기 아스라히 멀리 하늘에는 이름을 자랑처럼 별에도 별 별이 까닭입니다. 아이들의 별 추억과 파란 덮어 동경과 하나에 했던 밤을 버리었습니다. 딴은 하나에 릴케 이국 듯합니다. 새워 애기 어머님, 같이 별 풀이 하나에 버리었습니다. 이국 나는 위에도 라이너 잠, 된 어머니 때 까닭입니다. 아무 오면 마리아 별빛이 거외다. 지나고 하나 당신은 거외다. 별 이름과, 계절이 그러나 까닭이요, 봅니다.
"""
            )

            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
