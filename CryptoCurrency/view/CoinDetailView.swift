//
//  CoinDetailView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 22/12/2023.
//

import SwiftUI

struct CoinDetailView: View {
    
    @EnvironmentObject var vm : CoinViewModel
    let gridColoumns = [ GridItem(.flexible()),GridItem(.flexible())]
    
    let coin:CoinModel
    
    var body: some View {

        ScrollView {
            VStack{
                
                ChartView(coin: coin)
                    .frame(height:300)
                    .padding()
                
                Spacer()
                
                Text("\(coin.name) Detail View :-")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.leading)
                
                LazyVGrid(columns: gridColoumns,alignment: .leading){
                ForEach(vm.coinStates){ state in
                    
                    
                    MArketSatateView(State: state)
                        .padding(.horizontal)
                        .padding(.vertical,2)
                    
                }
                }
                
                
            }
            .navigationTitle(coin.name)
            .toolbar(content: {
                ToolbarItem {
                    HStack{
                        Text(coin.symbol.uppercased())
                        APIImageView(coin: coin)
                        
                    }
                }
            })
            .onAppear {
                vm.makeCoinState(coin: coin)
        }
        }
        
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.Coin)
            .environmentObject(CoinViewModel())
    }
}
