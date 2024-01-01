//
//  CoinImageDataService.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 22/12/2023.
//

import Foundation
import Combine
import UIKit


class CoinImageDataServec {
    
    @Published var APiImage : UIImage? = nil 
    var CoinImageCanceller : AnyCancellable?
    
    init(url:String){
        
        getDataFromApi(Url: url)
    }
    

    
    
    
    func getDataFromApi(Url:String){
        
        guard let url = URL(string: Url) else {
            print("error from Url making")
            return
        }
        
        CoinImageCanceller = URLSession.shared.dataTaskPublisher(for: url)
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
            .tryMap({ Data -> UIImage in
                
                return UIImage(data: Data)!
            })
            .sink { completion  in
                
                switch completion
                {
                case .finished :
                    break
                    
                case .failure(let error) :
                    print(error)
                }
                
            } receiveValue: { [weak self]  imageValue in
             
                self?.APiImage = imageValue
                
                self?.CoinImageCanceller?.cancel()
                
                
            }

        
        
        
        
    }
    
    
}
