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
    @IBOutlet weak var allCheckButton: CheckButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var agreeButton: BorderedButton!
    
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
            if terms.value?.contents.count == 0, terms.response?.statusCode == 200 {
                //동의할게 없으면 바로 진행
                delegate?.agreeComplete()
            }
            if let result = terms.value {
                self?.terms = result.contents
            }
        }
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        Task {
            let agree = try await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .agreeTerms(terms: self.terms.map({$0.code})))
            if (agree.response?.statusCode ?? 0) >= 200, (agree.response?.statusCode ?? 0) < 300 {
                delegate?.agreeComplete()
            }
        }
        
    }
    
    @IBAction func allCheckButtonAction(_ sender: Any) {
        if allCheckButton.checked {
            agreeButton.isEnabled = true
            tableView.visibleCells.forEach { cell in
                if let agreeCell = cell as? TermCell {
                    agreeCell.checked = true
                }
            }
        } else {
            agreeButton.isEnabled = false
            tableView.visibleCells.forEach { cell in
                if let agreeCell = cell as? TermCell {
                    agreeCell.checked = false
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TermCell {
            cell.checked.toggle()
            if isAllChecked() {
                allCheckButton.checked = true
                agreeButton.isEnabled = true
            } else {
                allCheckButton.checked = false
                agreeButton.isEnabled = false
            }
        }
    }
    
    private func isAllChecked() -> Bool {
        for index in 0..<terms.count {
            guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TermCell else { return false }
            if cell.checked == false {
                return false
            }
        }
        return true
    }
}
