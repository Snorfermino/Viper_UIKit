//
//  WalletRouter.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/16/21.
//

import UIKit

final class WalletRouter {
    static func presentWallet() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let walletVC = storyboard.instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController else {
            return UINavigationController(rootViewController: UIViewController())
        }
        let interactor = WalletInteractor()
        let presentor = WalletPresentor(interactor, delegate: walletVC)
        walletVC.presentor = presentor
        let navigationVC = UINavigationController(rootViewController: walletVC)
        navigationVC.navigationBar.topItem?.title = "Wallet"
        navigationVC.navigationBar.barTintColor = .black
        navigationVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
        return navigationVC
    }
}
