//
//  APIClient.swift
//  CoinHako_Viper
//
//  Created by Tien Dat on 6/15/21.
//

import PromiseKit
import Alamofire

final class APIClient {
    static let baseURL = "https://www.coinhako.com/api/v3/price/all_prices_for_mobile?counter_currency=USD"
    
    static func getCryptos() -> Promise<[Crypto]> {
        return Promise () { promise in
            Alamofire.request(URL(string: baseURL)!, method: .get).validate().responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                    promise.reject(error)
                    break
                case .success:
                    do {
                        let cryptos = try JSONDecoder().decode(Cryptos.self, from: response.data!)
                        print(cryptos.cryptos)
                        promise.fulfill(cryptos.cryptos)
                    } catch {
                        print("Error Decode")
                    }
                    break
                }
            }
        }
    }
}

