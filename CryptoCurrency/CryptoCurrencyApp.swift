//
//  CryptoCurrencyApp.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI
@main
struct Crypto_CurrencyApp: App {

    @StateObject var vm  = CoinViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
                    .environmentObject(vm)
            }

        }
    }
}
