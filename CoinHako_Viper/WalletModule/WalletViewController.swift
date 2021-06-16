//
//  WalletViewController.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var presentor: WalletPresentor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
}

extension WalletViewController: UITableViewDelegate {
    
    
}

