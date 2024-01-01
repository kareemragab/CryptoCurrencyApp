//
//  GlobalDataViewModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import Combine

class GlobalDataViewModel : ObservableObject {
    
    @Published var GlobalData :[MarketState] = []
    var canceler = Set<AnyCancellable>()
    var globalDataInstance = GlobalDataService ()
    
    init(){
        getData()
    }
    
    func getData(){
        
        globalDataInstance.$GlobalData
            .map{  value -> [MarketState] in
                
                var stateArra  :  [MarketState] = []
                guard let data = value.data  else{
                    return  [MarketState(title: "", value: "")]
                }
                 
                let marketcap = MarketState(title: "MarketCap", value: data.marketCap, PercenChange: data.marketCapChangePercentage24HUsd)
                let Volume = MarketState(title: "24h Volume", value: data.volume)
                
                let BtcCap = MarketState(title: "Btc Volume", value: data.btcVolume)
                
                let portfoli = MarketState(title: "Portfolio Volume", value: "$0.0", PercenChange: 0)
                
                stateArra.append(contentsOf: [ marketcap,Volume,BtcCap,portfoli ])
                return stateArra
                
            }
            .sink { [weak self] returnedval in
                
                self?.GlobalData = returnedval
                    
            }
            .store(in: &canceler)
        
    }
    
}
