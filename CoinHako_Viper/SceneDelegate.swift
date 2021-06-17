//
//  SceneDelegate.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/14/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = WalletRouter.presentWallet()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

