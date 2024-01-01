//
//  LocalFileManage.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    
 static let instance = LocalFileManager()
    
    func getImage(ImageName:String) -> UIImage? {
        guard let path = getPth(Name: ImageName)?.path else{
            return nil
        }
        guard  FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
        
        
    }
    
    
    
    func saveImage(image:UIImage,ImageName:String){
        guard let data = image.jpegData(compressionQuality:1.0) else
        {
            return
        }
        guard let path = getPth(Name: ImageName) else  {
            return
        }
        
        do {
            try data.write(to: path)
        }
        catch let error {
            print(error)
            
        }
        
        
        
        
        
    }
    
    
    func getPth(Name:String)->URL?{
        
        guard let url = FileManager
            .default
            .urls(for:.documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(Name)
        else {
            return nil
        }
        return url
        
    }
    
}
