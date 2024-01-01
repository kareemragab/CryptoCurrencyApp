//
//  GlobalDataService.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import Combine

class GlobalDataService {
    
    @Published var GlobalData = GlobalDataModel(data: nil)
    
    var coinCAnceller : AnyCancellable?
    
    init(){
        
        getDataFromApi()
    }
    
    
    
    
    func getDataFromApi(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            print("error from Url making")
            return
        }
        
        coinCAnceller = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse
                else {
                    throw URLError(.badServerResponse)
                }
                
                guard response.statusCode >= 200  && response.statusCode <= 300 else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink { completion  in
                
                switch completion
                {
                case .finished :
                    break
                    
                case .failure(let error) :
                    print(error)
                }
                
            } receiveValue: { [weak self] finalrReturnedValue in
                
                self?.GlobalData=finalrReturnedValue
                self?.coinCAnceller?.cancel()
        
            }

        
        
        
        
    }
    
}
