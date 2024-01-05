//
//  AgreeVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit
import PanModal
import Alamofire

protocol AgreeDelegate {
    func agreeComplete()
}

class AgreeVC: UIViewController {
    var delegate: AgreeDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    var terms: [Term] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TermCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "termCell")
        tableView.separatorStyle = .none
        tableView.bounces = false
        Task { [weak self] in
            let terms = try await OBNetworkManager.shared.asyncRequest(object: TermsResponse.self, router: .getTerms)
            if let result = terms.value {
                self?.terms = result.contents
            }
        }
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        delegate?.agreeComplete()
    }
}

extension AgreeVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var dragIndicatorBackgroundColor: UIColor {
        return .clear
    }
}

extension AgreeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "termCell", for: indexPath) as? TermCell {
            cell.selectionStyle = .none
            cell.term = terms[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}
