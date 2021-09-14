//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdateRate(_ rate: Double)
   func didUpdateCurrency(_ currency: String)
    
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    var selectedCrypto: String = "0"
    var selectedCurrency: String = "0"
    let apiKey = "C060EC93-9FBE-459C-96B2-290024444CA2"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD","BRL","INR","CNY","EUR","GBP","USD","IDR","ILS","JPY","MXN","NOK","NZD"]
    let cryptoArray = ["BTC","LTC","ETH","DOGE","ENJ","MATIC","XRP","ARK","XVG","UFT","KMD","COTI"]
    
    mutating func selectCrypto(for crypto: String)
    
    {
        self.selectedCrypto = crypto
        
        }
    
   mutating func selectCurrency(for currency: String)
    {
    self.selectedCurrency = currency
     let finalURL = "\(baseURL)\(selectedCrypto)/\(selectedCurrency)?apikey=\(apiKey)"
    print(finalURL)
    
        performRequest(finalURL)
    
    delegate?.didUpdateCurrency(currency)
    }
    
    
    func performRequest(_ finalURL: String)
    {
        if let url = URL(string: finalURL)
        {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data,response,error) in
          if error != nil
          {
            delegate?.didFailWithError(error: error!)
            return
          }
            if let safeDate = data
            {
            if let parseData = parseJSON(safeDate)
            {
                print(parseData)
                delegate?.didUpdateRate(parseData)
            }
              
            }
        }
        
        task.resume()
    }
}
    func parseJSON(_ data: Data) -> Double?
    {
        let decoder = JSONDecoder()
        do {
        let decodedData =  try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
           
            return rate
        
    }
        catch
        {
            delegate?.didFailWithError(error: error)
            return nil
        }
    
}
}
