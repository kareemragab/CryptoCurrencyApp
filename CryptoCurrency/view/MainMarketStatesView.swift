//
//  MainMarketStatesView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 22/12/2023.
//

import SwiftUI

struct MainMarketStatesView: View {
    
    
    // property
    
    @Binding var iSportfolioOn : Bool
 
    @StateObject var vm  = GlobalDataViewModel()
    
  
    
   
    //body
    var body: some View {
    
        HStack( spacing:0){
            
            ForEach(vm.GlobalData) { state in
                MArketSatateView(State: state)
                    .frame(width: UIScreen.main.bounds.width / 3 , alignment: .center)
                    .padding(.horizontal,2)
                
                
                
            }
            
        }.frame(width: UIScreen.main.bounds.width, alignment: iSportfolioOn ? .trailing : .leading )
        
    }
}

struct MainMarketStatesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMarketStatesView(iSportfolioOn: .constant(false))
    }
}
