//
//  GloblaDataModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation

struct GlobalDataModel:Codable {
    let data : BranchData?
}


struct BranchData: Codable {

       let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
       let marketCapChangePercentage24HUsd: Double    
    
    enum CodingKeys : String , CodingKey {
        
        case totalMarketCap = "total_market_cap"
        case totalVolume =  "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
        if let item = totalMarketCap.first(where: { $0.key=="usd" }){
            
            return String(item .value.formattedWithAbbreviations())
        }
        return ""
        
    }
    var volume : String {
        if let item = totalVolume.first(where: { $0.key=="usd" }){
            
            return String(item .value.formattedWithAbbreviations())
        }
        return ""
        
    }
    
    var btcVolume : String {
        if let item = totalVolume.first(where: { $0.key=="btc" }){
            
            return String(item .value.formattedWithAbbreviations()+"%")
        }
        return ""
        
    }
    

}
