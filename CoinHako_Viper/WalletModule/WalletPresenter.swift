//
//  WalletPresenter.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import Foundation

class WalletPresentor {
    var interactor: WalletInteractor
    private(set) var cryptos: [Crypto]?
    
    init(_ interactor: WalletInteractor) {
        self.interactor = interactor
    }
    
    func getCryptos() {
        interactor.getCryptos()
    }
    
    func startUpdateCryptos() {
        interactor.startUpdateCryptos()
    }
    
    
    
}
