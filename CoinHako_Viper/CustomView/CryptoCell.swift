//
//  CryptoCell.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import UIKit

class CryptoCell: UITableViewCell {
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var baseLb: UILabel!
    @IBOutlet weak var buyLb: UILabel!
    @IBOutlet weak var sellLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
    }
    
    func setupCell(with crypto: Crypto) {
        nameLb.text = crypto.name
        baseLb.text = crypto.base
        buyLb.text = crypto.buy
        sellLb.text = crypto.sell
    }
}
