//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
var coinManager = CoinManager()
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var cryptoRow: Int = 0
    var currencyRow: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        }
}

 //MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return coinManager.cryptoArray.count
        
        }else {
            return coinManager.currencyArray.count
        }
        
    }
}
 //MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if component == 0
       {
        return coinManager.cryptoArray[row]
       }
       else{
        return coinManager.currencyArray[row]
       }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if component == 0
       {
        cryptoRow = row
        coinManager.selectCrypto(for: coinManager.cryptoArray[row])
        coinManager.selectCurrency(for: coinManager.currencyArray[currencyRow])
        
        
       }
        else
       {
        currencyRow = row
        coinManager.selectCurrency(for: coinManager.currencyArray[row])
        coinManager.selectCrypto(for: coinManager.cryptoArray[cryptoRow])
       }
    }
    
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate
{
    func didUpdateRate(_ rate: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format:"%0.2f", rate)
        }
    }
    
    func didUpdateCurrency(_ currency: String) {
        DispatchQueue.main.async {
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
    
    
         
     
    
    
     
    
