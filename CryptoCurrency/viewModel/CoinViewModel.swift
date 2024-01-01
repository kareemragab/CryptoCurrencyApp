//
//  CoinViewModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinViewModel : ObservableObject {

    @Published var AllCoins : [CoinModel] = []
    @Published var  PortFolioCoins : [CoinModel] = []
    @Published var coinStates :[MarketState] = []
    @Published var SearchText : String = ""
    var portfolioDataServec = PortfolioDataService()
    var cancelablesItem = Set<AnyCancellable>()
    let dataService = CoinDataService()
    
    
    init(){
        getCoinDataFromDataSevice()
    }
    
    func getCoinDataFromDataSevice(){
        
        $SearchText
            .combineLatest( dataService.$Coins)
            .map { (SearchText, NormalCoins) ->[CoinModel] in
                
                guard !SearchText.isEmpty else {
                    return NormalCoins
                }
                
                return NormalCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(SearchText.lowercased()) ||
                           coin.symbol.lowercased().contains(SearchText.lowercased()) ||
                           coin.id.lowercased().contains(SearchText.lowercased())
                }
                
                
            }
            .sink { [weak self] val in
                
                self?.AllCoins = val
             
                
            }
            .store(in: &cancelablesItem)
        
        
        
        portfolioDataServec.$SavedEntity
            .combineLatest($AllCoins)
            .map { (SavedEntites, Allcoins)->[CoinModel] in
                Allcoins
                    .compactMap { coin->CoinModel? in
                        
                        guard let entity = SavedEntites.first(where: {$0.coinid == coin.id}) else{
                            return nil
                        }
                        
                        return coin.currentHoldingsUpdate(amount: entity.amount)
                        
                        
                    }
                
                
            }
            .sink{ [weak self ] returnedVal in
                
                self?.PortFolioCoins = returnedVal
            
            }
            .store(in: &cancelablesItem)
        
        
    }
    
    func Reloading(){
        dataService.getDataFromApi()
        portfolioDataServec.getEntity()
    }
    func getUpdateCoreData(coin:CoinModel,amount:Double){
        portfolioDataServec.getUpdateService(coin: coin, amount: amount)
    }
    
    func makeCoinState(coin:CoinModel){

        let Currentprice =  MarketState(title: "Current Price", value: String(coin.currentPrice), PercenChange: coin.priceChange24H)
        let marketCap = MarketState(title: "Coin MarketCap", value: coin.marketCap?.formattedWithAbbreviations() ?? "0.0", PercenChange: coin.marketCapChangePercentage24H)
        let CoinRank = MarketState(title: "Coin Rank", value: String(coin.rank))
        let volume = MarketState(title: "Volume", value:coin.totalVolume?.formattedWithAbbreviations() ?? "0.0")
        let priceH24 = MarketState(title: "24H High", value:String(coin.high24H ?? 0.0))
        let pricel24 = MarketState(title: "24H High", value:String(coin.low24H ?? 0.0))
        let priceChange24h = MarketState(title: "Price Change 24H", value: coin.priceChange24H?.asPecetageNumber() ?? "0.0")
        let MArketCapChange = MarketState(title: "Market Cap Change 24H", value: coin.marketCapChangePercentage24H?.asPecetageNumber() ?? "0.0")
        
        coinStates.append(contentsOf: [Currentprice,marketCap,CoinRank,volume,priceH24,pricel24,priceChange24h,MArketCapChange])

    }
}
