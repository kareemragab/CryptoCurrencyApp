//
//  HomeView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 22/12/2023.
//

import SwiftUI

struct HomeView: View {
    //property
    @State var ShowPorfolio = false
    @EnvironmentObject var vm : CoinViewModel
    @State var ShowSheet : Bool = false
    var dtaserves = CoinDataService()
    

    //body
    var body: some View {
        ZStack{
            Color.Theme.BackGround3
                .ignoresSafeArea()
                .sheet(isPresented:$ShowSheet) {
                    
                    PotfolioSheetView()
                        .environmentObject(vm)
                }
            
            VStack{
                
               HeaderView
                
                SearchBarView(SearchText: $vm.SearchText)
                
                MainMarketStatesView(iSportfolioOn: $ShowPorfolio)
                
                List{
                    if ShowPorfolio {
                        ForEach(vm.PortFolioCoins) { coin in

                            NavigationLink {
                                CoinDetailView(coin: coin)
                                    .environmentObject(vm)
                            } label: {
                                CoinRowView(coin: coin ,showHoldings: $ShowPorfolio )
                                    .transition(.move(edge: .trailing))
                                    .environmentObject(vm)
                                    
                            }

                        }
                        
                    }
                    else{
                        ForEach(vm.AllCoins) { coin in
                            NavigationLink {
                                CoinDetailView(coin: coin)
                                    .environmentObject(vm)
                            } label: {
                                
                                CoinRowView(coin: coin ,showHoldings: $ShowPorfolio )
                                    .transition(.move(edge: .trailing))

                            }
                            
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
        }
        .overlay(
            Image(systemName: "arrow.counterclockwise")
                .resizable()
                .scaledToFill()
                .padding()
                .background(Color.white.cornerRadius(50).shadow(color: .black, radius: 20, x: 0, y: 0))
                .frame(width: 50, height: 50, alignment: .center)
                .onTapGesture {
                    vm.Reloading()
                }
                .padding()
            ,alignment: .bottomTrailing)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
            .environmentObject(CoinViewModel())
    }
}


extension HomeView {
    var HeaderView :some View {
        HStack{
            CircleButton(ImageName:ShowPorfolio ?  "plus" :  "info")
                
                .animation(.none)
                .background(
                    CirCleButtonAnimationEffect(IsAnimated: $ShowPorfolio).scaleEffect(2))
                .padding(.leading,20)
                .onTapGesture {
                    if ShowPorfolio {
                    ShowSheet.toggle()
                    }
                }
            
            Spacer()
            Text(ShowPorfolio ? "Portfolio":"Live Price")
                .font(.system(size: 25, weight: .semibold, design: .serif))
                .animation(.none)
            
            Spacer()
            CircleButton(ImageName: "chevron.right")
                .rotationEffect(ShowPorfolio ? Angle(degrees: 180) : Angle(degrees: 0))
                .padding(.trailing,20)
                
                .onTapGesture {
                    withAnimation(.linear){
                        ShowPorfolio.toggle()
                        
                    }
                }
            

        }
    }
    
}
