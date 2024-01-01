//
//  portfolioDataService.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import Foundation
import CoreData

class PortfolioDataService{
    
    private let container : NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
   
    @Published var  SavedEntity : [PortfolioEntity] = []
    
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print(error)
                
            }
            
        }
        getEntity()
        
    }
    
    //Crud
    
    func getUpdateService(coin:CoinModel,amount:Double){
        if let entity = SavedEntity.first(where: {$0.coinid==coin.id}){
            
            if amount>0{
                update(entity: entity, amount: amount)
            }else{
                deleteEntity(entity: entity)
                
                
            }
        }
        else{
            AddEntitny(Coin: coin, amount: amount)
        }
        
        
    }
    
    
    
    func AddEntitny(Coin:CoinModel,amount:Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinid = Coin.id
        entity.amount=amount
       Save()
        
    }
    
    
    func getEntity(){
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            SavedEntity = try container.viewContext.fetch(request)
        }catch{
            print("error with get data")
        }
        
        Save()
        
    }
    
    
    
    func update(entity:PortfolioEntity,amount:Double){
        entity.amount=amount
        Save()
        
    }
    
    func deleteEntity(entity:PortfolioEntity){
        container.viewContext.delete(entity)
        Save()
    }
    
    
    func Save(){
        
        
        do{
            try container.viewContext.save()
        }
        catch{
            print("error with Saving")
        }
        
        
        
    }
    

}
