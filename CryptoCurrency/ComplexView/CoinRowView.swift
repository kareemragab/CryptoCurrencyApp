//
//  CoinRowView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    @Binding var  showHoldings : Bool
    
    var body: some View {
        HStack(spacing:10) {
           
            
            lefItems
                
                .animation(.none)
            
            Spacer()
            if showHoldings {
                HoldingsItem
               }
            Spacer()
            rightItem.padding(.horizontal)
          
            
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.Coin,showHoldings: .constant(true))
    }
}

extension CoinRowView {
    var lefItems : some View {
        
        HStack{
            Text(String(coin.rank))
                .frame(width: 25 , alignment: .leading)
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .foregroundColor(Color.Theme.SecondaryText)
               
            APIImageView(coin: coin)
             
            
            Text(coin.symbol.uppercased())
                .font(.system(size: 15, weight: .semibold, design: .serif))
                

            
               
        }
    }
}


extension CoinRowView {
    
    var HoldingsItem : some View {
        
        VStack(alignment:.center,spacing:3){
            
            Text(coin.currentHoldings?.AsCurrnency6Digit() ?? "$0.0"  )
                .font(.system(size: 15, weight: .medium, design: .serif))
        
            Text(coin.currentHoldings?.asNuberString() ?? "0.0")
                .font(.system(size: 15, weight: .medium, design: .serif))
            .foregroundColor(
                coin.priceChangePercentage24H ?? 0.0  >= 0 ?  Color.Theme.Green :  Color.Theme.Red
            )
        
    }
    }
    
}


extension CoinRowView {
    var rightItem : some View {
        VStack(alignment:.trailing,spacing:3){
            
            Text(coin.currentPrice.AsCurrnency6Digit())
                .font(.system(size: 15, weight: .medium, design: .serif))
               
            
            Text(coin.priceChangePercentage24H?.asPecetageNumber() ?? "0.0%")
                .font(.system(size: 15, weight: .medium, design: .serif))
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0.0  >= 0 ?  Color.Theme.Green :  Color.Theme.Red
                )
            
            
        }
    }
    
    
}
