//
//  WalletViewController.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var presentor: WalletPresentor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presentor.getCryptos()
        presentor.startUpdateCryptos()
    }
    
    func setupUI() {
        // Setup search textField
        textField.addTarget(self, action: #selector(textSearchChange(_:)), for: .editingChanged)
        textField.attributedPlaceholder = NSAttributedString(string: "Search...",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 2
        
        // Setup tableView
        tableView.estimatedRowHeight = 70
        tableView.keyboardDismissMode = .onDrag
        tableView.accessibilityIdentifier = "cryptoList"
    }
    
    @objc func textSearchChange(_ sender: UITextField){
        // Add throttle to reduce the filter times each time text is changed
        Throttler.go(delay: 0.5) { [weak self] in
            self?.presentor.filterCryptos(by: sender.text ?? "")
        }
    }
}

// MARK:UITableViewDataSource
extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentor.filteredCryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell") as? CryptoCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: presentor.filteredCryptos[indexPath.row])
        return cell
    }
}

// MARK:WalletPresenterDelegate
extension WalletViewController: WalletPresenterDelegate {
    func cryptoFiltered() {
        // Update table view when search text changed
        tableView.reloadData()
    }
    
    func cryptoPriceUpdated() {
        guard let visibleRows = tableView.indexPathsForVisibleRows, visibleRows.count > 0 else {
            // Mostly run only at first when crypto price is not fetched
            tableView.reloadData()
            return
        }
        // Only update UI of visible rows avoiding whole table reload for efficient resources useage
        for indexPath in visibleRows {
            if let cell = tableView.cellForRow(at: indexPath) as? CryptoCell {
                cell.setupCell(with: presentor.getCrypto(at: indexPath))
            }
        }
        tableView.reloadRows(at: visibleRows, with: .none)
    }
}
