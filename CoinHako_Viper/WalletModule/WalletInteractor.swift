//
//  WalletInteractor.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import Foundation
import PromiseKit

protocol WalletInteractorDelegate {
    func cryptoPriceUpdated()
}

class WalletInteractor {
    var cryptos: [Crypto] = []
    var delegate: WalletInteractorDelegate?
    
    func getCryptos() {
        _ = firstly {
            APIClient.getCryptos()
        }.done { cryptos in
            self.cryptos = cryptos
            self.delegate?.cryptoPriceUpdated()
        }
    }
    
    func getCrypto(at indexPath: IndexPath) -> Crypto {
        cryptos[indexPath.row]
    }
}
