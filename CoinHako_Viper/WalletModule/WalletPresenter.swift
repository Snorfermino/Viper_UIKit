//
//  WalletPresenter.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import Foundation
import PromiseKit

protocol WalletPresenterDelegate {
    func cryptoPriceUpdated()
    func cryptoFiltered()
}

class WalletPresentor {
    var interactor: WalletInteractor
    private lazy var cryptos: [Crypto] = []
    private(set) lazy var filteredCryptos: [Crypto] = []
    lazy var filteredText = ""
    var delegate: WalletPresenterDelegate?
    private var timer:Timer?
    
    init(_ interactor: WalletInteractor, delegate: WalletPresenterDelegate) {
        self.interactor = interactor
        self.interactor.delegate = self
        self.delegate = delegate
    }
    
    func getCrypto(at indexPath: IndexPath) -> Crypto {
        return filteredCryptos[indexPath.row]
    }
    
    func getCryptos() {
        interactor.getCryptos()
    }
    
    func startUpdateCryptos() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getCryptos()
        }
    }
    
    func filterCryptos(by text: String) {
        filteredText = text
        filteredCryptos = text.isEmpty ? cryptos : cryptos.filter {  $0.name.localizedCaseInsensitiveContains(text) || $0.base.localizedCaseInsensitiveContains(text) }
        delegate?.cryptoFiltered()
    }
}

// MARK:WalletInteractorDelegate
extension WalletPresentor: WalletInteractorDelegate {
    func cryptoPriceUpdated() {
        cryptos = interactor.cryptos.sorted { $0.name < $1.name }
        filterCryptos(by: filteredText)
        delegate?.cryptoPriceUpdated()
    }
}
