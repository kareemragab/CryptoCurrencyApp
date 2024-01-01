//
//  CircleButton.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI

struct CircleButton: View {
    
    let ImageName : String
    
    var body: some View {
Image(systemName: ImageName)
            .font(.system(size: 25, weight: .semibold, design: .serif))
          
            .frame(width: 50, height: 50, alignment: .center)
            .padding(5)
            .background(Color.white .cornerRadius(50).shadow(color: .black, radius: 10, x: 0, y: 0))
           
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(ImageName: "")
    }
}
