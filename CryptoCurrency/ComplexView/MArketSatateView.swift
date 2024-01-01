//
//  MArketSatateModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI

struct MArketSatateView: View {
    
    let State : MarketState
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(State.Title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(State.Value)
                .font(.system(size: 20, weight: .semibold, design: .serif))
                .padding(.bottom,State.percentChange == nil ?  25 : 0)
            
            if State.percentChange != nil {
                
                HStack{
                    Image(systemName: "triangle.fill")
                        .rotationEffect(Angle(degrees: State.percentChange! >= 0 ? 0 : 180))
                    Text(State.percentChange!.asPecetageNumber())
                        .font(.system(size: 15, weight: .medium, design: .default))
                }
                .foregroundColor(State.percentChange! >= 0 ? Color.Theme.Green : Color.Theme.Red)
            }
            
        }
        
    }
}

struct MArketSatateModel_Previews: PreviewProvider {
    static var previews: some View {
        MArketSatateView(State: dev.St1)
    }
}
