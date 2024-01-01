//
//  CoinImageViewModel.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var CoinImageUi : UIImage? = nil
    @Published var IsLoading : Bool = false
    var fileManager = LocalFileManager.instance
    
    var coin : CoinModel
    var imageDataServec:CoinImageDataServec
    var canelbles = Set<AnyCancellable>()
    
    
    
    
    init(Coin:CoinModel){
        self.coin = Coin
        self.imageDataServec = CoinImageDataServec(url: Coin.image)
      
        self.IsLoading = true
        
        getImageFromDevice(imageName: Coin.id)
        
        
        
    }
    
    func getImageFromDevice(imageName:String){
        
        guard let Image = fileManager.getImage(ImageName:imageName) else {
            getImagefromDownload(Imagename: imageName)
            return
        }
        CoinImageUi = Image
    }
    
    
    func getImagefromDownload(Imagename:String){
        
        
        imageDataServec.$APiImage
            .sink  { [weak self] _ in
                
                self?.IsLoading = false
                
            } receiveValue: { [weak self] returnedVal in
                print("overload On server")
                self?.CoinImageUi = returnedVal
                guard let image = returnedVal else {
                    return
                }
                self?.fileManager.saveImage(image: image, ImageName: Imagename)
            }
            .store(in: &canelbles)
        
    }
    
    
    
    
    
    
}
