//
//  PotfolioSheetView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 22/12/2023.
//
import SwiftUI

struct PotfolioSheetView: View {
    @EnvironmentObject var vm : CoinViewModel
    @State var SelectedCoin:CoinModel?
    @Environment(\.dismiss) var dismiss
    @State var AmountoFQuantity = ""
    
    @State var SaveButtonPressed = false
    @State var showCkeckMArk = false
    var body: some View {
        
        NavigationView{
            
            VStack {
                SearchBarView(SearchText: $vm.SearchText)
                
                IconView
                
                
                if SelectedCoin != nil {
                    coinAmountView
                    
                }
                
               
                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                    }

                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .opacity(showCkeckMArk ? 1 : 0)
                        
                        
                        Text("Save")
                            .opacity(SaveButtonPressed ? 0 : 1)
                            .onTapGesture {
                                saveButtonPressed()
                            }
                    }
                    
                    
                }
                
            })
            .navigationTitle("Edit portfolio")
        }
   
    }
}

struct PotfolioSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PotfolioSheetView(SelectedCoin:dev.Coin)
            .environmentObject(CoinViewModel())
    }
}


extension PotfolioSheetView {
    
    var IconView:some View {
        ScrollView(.horizontal,showsIndicators: true){
            
            LazyHStack{
                ForEach(vm.AllCoins) { coin in
                    
                    SheetCardView(coin: coin)
                        .frame(width: 120, height: 160, alignment: .center)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                SaveButtonPressed = false
                               updateselectedcoin(coin: coin)
                            }
                           
                        }
                        .background(
                        
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.green, lineWidth: 4)
                                .opacity(SelectedCoin != nil && SelectedCoin?.id == coin.id ? 1 : 0)
                                
                        ).padding(.horizontal,5)
                    
                }
                
                
            }
            
        }.frame( height: 200, alignment: .center)
    }
}

extension PotfolioSheetView{
    func getValue()->String {
        
        guard let amount = Double(AmountoFQuantity)else {
            return "$0.0"
        }
        
        return "$" + String((amount * SelectedCoin!.currentPrice).formattedWithAbbreviations())
        
        
        
    }
}

extension PotfolioSheetView{
    
   var  coinAmountView : some View {
        VStack{
            HStack{
                Text("Current Price Of \(SelectedCoin!.name) :")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.leading,5)
                
                Spacer()
                
                Text(SelectedCoin!.currentPrice.AsCurrnency6Digit())
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.trailing,5)

                
            }.padding(.vertical)
            Divider()
            
            HStack {
                Text("Amount In Your Portfolio:")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.leading,5)
                
                Spacer()
        
                TextField("Ex:1.4", text: $AmountoFQuantity)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing)
                  
                
                
            }
            Divider()
            
            HStack {
                Text("Amount Of Current Value")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.leading,5)
                
                Spacer()
        
                Text(getValue())
                    .padding(.trailing)
                
                
            }
            
        }
    }
    
}


extension  PotfolioSheetView {
    func saveButtonPressed(){
        
        
        // save to CoreDAta
       if let amount = Double(AmountoFQuantity){
           if SelectedCoin != nil {
           vm.getUpdateCoreData(coin: SelectedCoin!, amount: amount)
           }
        }
        
        //
        withAnimation {
            SaveButtonPressed = true
            showCkeckMArk=true
            SelectedCoin=nil
            AmountoFQuantity = ""

         
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            withAnimation {
                showCkeckMArk=false
            }
        }
        
        
      
        
        
        vm.Reloading()

    }
    
}

extension PotfolioSheetView{
    
    func updateselectedcoin(coin:CoinModel){
        
        SelectedCoin=coin
        
        if let portfolioCoin = vm.PortFolioCoins.first(where: {$0.id==coin.id}) {
            AmountoFQuantity=String(portfolioCoin.currentHoldings!)
        }else{
            AmountoFQuantity=""
        }
       
        
        
    }
    
    
}
