//
//  SearchBarView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var SearchText:String
    
    var body: some View {
        HStack(spacing:0){
            Image(systemName: "magnifyingglass")
                .padding()
            
            TextField("Searc By Name Or Symbol", text: $SearchText)
                .padding(.vertical)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding()
                        .opacity(SearchText.isEmpty ? 0.0 :  1.0)
                        .onTapGesture {
                            SearchText = ""
                        }
                    ,alignment: .trailing)

        }
        .foregroundColor(SearchText.isEmpty ? Color.Theme.SecondaryText : .Theme.ACCENT )
        .background(Color.white.cornerRadius(20).shadow(color: .black.opacity(0.5), radius: 18, x: 0, y: 0))
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(SearchText: .constant(""))
    }
}
