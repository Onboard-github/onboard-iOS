//
//  TermsView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/27.
//

import UIKit

import SnapKit
import WebKit

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
    private let webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(url: String) {
        guard let url = URL(string: url) else { return }
        self.webView.load(URLRequest(url: url))
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(self.webView)
        
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = TermsView()

            view.bind(url: "https://www.naver.com")

            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
