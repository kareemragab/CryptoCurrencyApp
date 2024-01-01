//
//  MarketSatateModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation

struct MarketState:Identifiable {
    let id = UUID().uuidString
    let Title :String
    let Value : String
    let percentChange:Double?
    
    init(title:String,value:String , PercenChange:Double?=nil){
        Title=title
        Value=value
        percentChange=PercenChange
    }
    
}


