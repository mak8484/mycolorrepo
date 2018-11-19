//
//  Storage.swift
//  Matchee
//
//  Created by Marco Mantegazza on 9/1/17.
//  Copyright © 2017 FYDEM Pte Ltd. All rights reserved.
//

import UIKit
import CoreData

class Storage: NSObject {

    // MARK: Storage
    
    func initClothesStorage(){
        
        let context = getContext()
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Clothes")
        fetchRequest.returnsObjectsAsFaults = false
        
        var count:Int = 0
        
        do{
            count = try context.count(for: fetchRequest)
        }
        catch {
            print("could not fetch count")
        }
        
        //if count > 0 means there is already sets stored, else store the initial set
        if count > 0{
            print("\(count) clothing pieces already exists in DB")
        }
        else{
            
            //Get existing clothes names for men
            var clothesGetter = ClothesMen()
            let clothesArray:[clothPiece] = clothesGetter.getMenClothesFromStruct()
            var id:Int64 = 0
            
            //Create db entries for new clothes for men
            for clothes in clothesArray {
                let newCloth = NSEntityDescription.insertNewObject(forEntityName: "Clothes", into: context)
                
                newCloth.setValue(clothes.cloth, forKey: "name")
                newCloth.setValue(clothes.cloth, forKey: "imageName")
                newCloth.setValue(id, forKey: "id")
                newCloth.setValue(0, forKey: "gender")
                newCloth.setValue(NSKeyedArchiver.archivedData(withRootObject: UIColor.lightGray), forKey: "color")
                newCloth.setValue(clothes.drawingOrder.rawValue, forKey: "drawingOrder")
                
                do {
                    try context.save()
                    print("\(clothes) with id \(id) was saved")
                    id = id + 1
                }
                catch{
                    print("could not save standard cloth")
                }
            }
            
            var clothesGetterWomen = ClothesWomen()
            let clothesArrayWomen:[clothPiece] = clothesGetterWomen.getWomenClothesFromStruct()
            
            //Create db entries for new clothes
            for clothes in clothesArrayWomen {
                let newCloth = NSEntityDescription.insertNewObject(forEntityName: "Clothes", into: context)
                
                newCloth.setValue(clothes.cloth, forKey: "name")
                newCloth.setValue(clothes.cloth, forKey: "imageName")
                newCloth.setValue(id, forKey: "id")
                newCloth.setValue(1, forKey: "gender")
                newCloth.setValue(NSKeyedArchiver.archivedData(withRootObject: UIColor.lightGray), forKey: "color")
                newCloth.setValue(clothes.drawingOrder.rawValue, forKey: "drawingOrder")
                
                do {
                    try context.save()
                    print("\(clothes) with id \(id) was saved")
                    id = id + 1
                }
                catch{
                    print("could not save standard cloth")
                }
            }
            
            //Create standard clothes set for men
            
            fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ClothesSet")
            fetchRequest.returnsObjectsAsFaults = false
            count = 0
            
            do{
                count = try context.count(for: fetchRequest)
            }
            catch {
                print("could not fetch count")
            }
            
            if count > 0 {
                print(count)
            }
            else{
            
                //Create set for man
                let newClothesSet = NSEntityDescription.insertNewObject(forEntityName: "ClothesSet", into: context)
                newClothesSet.setValue("Standard set man", forKey: "name")
                newClothesSet.setValue(false, forKey: "isCurrent")
                newClothesSet.setValue(0, forKey: "id")
                newClothesSet.setValue(0, forKey: "gender")
                newClothesSet.setValue(NSKeyedArchiver.archivedData(withRootObject:[0,7,5,4]), forKey: "clothesIds")
                
                do {
                    try context.save()
                    print("Men set was saved")
                }
                catch{
                    print("could not save set")
                }
                
                //Create set for woman
                let newClothesSetWoman = NSEntityDescription.insertNewObject(forEntityName: "ClothesSet", into: context)
                newClothesSetWoman.setValue("Standard set woman", forKey: "name")
                newClothesSetWoman.setValue(false, forKey: "isCurrent")
                newClothesSetWoman.setValue(1, forKey: "id")
                newClothesSetWoman.setValue(1, forKey: "gender")
                newClothesSetWoman.setValue(NSKeyedArchiver.archivedData(withRootObject:[9,14,12,11]), forKey: "clothesIds")
                
                do {
                    try context.save()
                    print("Women set was saved")
                }
                catch{
                    print("could not save set")
                }
            }
        }
        
    }
    
    
    func storeClothesSet (clothesArray:[Cloth]) -> Bool{
        
        let context = getContext()
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clothes")
        var predicate = NSPredicate(format: "id >= 0", argumentArray: nil)
        var sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        var error = NSError()
        var clothID = 0
        var clothIDArray:[Int] = [Int]()
        
        // Assign fetch request properties
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        
        //Get the latest id stored for Clothes
        do {
            let fetchedSet = try context.fetch(fetchRequest) as! [Clothes]
            
            if fetchedSet.count > 0 {
                print("latest stored clothID: \(fetchedSet[0].id)")
                clothID = Int(fetchedSet[0].id)
                //Save current clothes in DB
                for clothes in clothesArray {
                    clothID = clothID + 1
                    clothIDArray.append(clothID)
                    let newCloth = NSEntityDescription.insertNewObject(forEntityName: "Clothes", into: context)
                    
                    newCloth.setValue(clothes.name, forKey: "name")
                    newCloth.setValue(clothes.name, forKey: "imageName")
                    newCloth.setValue(clothID, forKey: "id")
                    let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
                    if currentGender == "M"{
                        newCloth.setValue(0, forKey: "gender")
                    }
                    else{
                        newCloth.setValue(1, forKey: "gender")
                    }
                    newCloth.setValue(NSKeyedArchiver.archivedData(withRootObject: clothes.color), forKey: "color")
                    newCloth.setValue(clothes.drawingOrder.rawValue, forKey: "drawingOrder")
                    
                    do {
                        try context.save()
                        print("\(clothes) with id \(clothID) was saved")
                        //clothID = clothID + 1
                    }
                    catch{
                        print("could not save standard cloth")
                    }
                }

            }
        }catch{
            return false
        }

        //Get the latest id stored for a ClothesSet
        
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothesSet")
        predicate = NSPredicate(format: "id >= 0", argumentArray: nil)
        sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        error = NSError()
        
        // Assign fetch request properties
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 1
        fetchRequest.fetchLimit = 1
        

        do {
            let fetchedSet = try context.fetch(fetchRequest) as! [ClothesSet]
        
            if fetchedSet.count > 0 {
                print("Latest stored set: \(fetchedSet[0].id)")
                
                //Create set
                let newClothesSet = NSEntityDescription.insertNewObject(forEntityName: "ClothesSet", into: context)
                newClothesSet.setValue("\(fetchedSet[0].id+1)", forKey: "name")
                newClothesSet.setValue(true, forKey: "isCurrent")
                newClothesSet.setValue(fetchedSet[0].id+1, forKey: "id")
                
                let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
                if currentGender == "M"{
                    newClothesSet.setValue(0, forKey: "gender")
                }
                else{
                    newClothesSet.setValue(1, forKey: "gender")
                }
                
                newClothesSet.setValue(NSKeyedArchiver.archivedData(withRootObject:clothIDArray), forKey: "clothesIds")
                
                do {
                    try context.save()
                    self.changeClothesSetToCurrent(setId: Int(fetchedSet[0].id) + 1)//MNFMFD
                    print("New set was saved")
                }
                catch{
                    print("could not save set")
                }

                
                return true
            }
        
        }catch{
            return false
        }
        
        return false
    }
    
    public func storeCurrentClothesSet (clothesArray:[Cloth]) {
        
        let context = getContext()
        var id = -1
        
        let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
        if currentGender == "W"{
            id = id - 4
        }

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clothes")
        let predicate = NSPredicate(format: "id < 0", argumentArray: nil)
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        var error = NSError()
        // Assign fetch request properties
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 4
        fetchRequest.fetchLimit = 4
        
        // Handle results
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            if fetchedResults.count > 0 {
                
                var idForArray = 0
                
                for result in fetchedResults as! [NSManagedObject]{
                
                    result.setValue(clothesArray[idForArray].name, forKey: "name")
                    result.setValue(clothesArray[idForArray].name, forKey: "imageName")
                    result.setValue(id, forKey: "id")
                    result.setValue(clothesArray[idForArray].gender, forKey: "gender")
                    result.setValue(NSKeyedArchiver.archivedData(withRootObject: clothesArray[idForArray].color), forKey: "color")
                    result.setValue(clothesArray[idForArray].drawingOrder.rawValue, forKey: "drawingOrder")
                    
                    do {
                        try context.save()
                        print("Cloth was saved as current cloth with id \(id)")
                        id = id - 1
                        idForArray = idForArray + 1
                    }
                    catch{
                        print("could not save standard cloth")
                    }
                }
            }
            else{ 
                //create the first db entry as current clothes set saved 
                //Create db entries for new clothes
                for clothes in clothesArray {
                    let newCloth = NSEntityDescription.insertNewObject(forEntityName: "Clothes", into: context)
                    
                    newCloth.setValue(clothes.name, forKey: "name")
                    newCloth.setValue(clothes.name, forKey: "imageName")
                    newCloth.setValue(id, forKey: "id")
                    newCloth.setValue(clothes.gender, forKey: "gender")
                    newCloth.setValue(NSKeyedArchiver.archivedData(withRootObject: clothes.color), forKey: "color")
                    newCloth.setValue(clothes.drawingOrder.rawValue, forKey: "drawingOrder")
                    
                    do {
                        try context.save()
                        print("Cloth with id \(id) was created ")
                        id = id - 1
                    }
                    catch{
                        print("could not save standard cloth")
                    }
                }

            
            
            }
        } 
        catch{}

    }

    func getCurrentClothingSet() -> [Cloth]{

        let currentGender:String = UserDefaults.standard.string(forKey: "Matchee.currentGender")!
        var idArray:[Int]
        
        if currentGender == "M"{
            idArray = [-1,-2,-3,-4]
        }
        else{
            idArray = [-5,-6,-7,-8]
        }
        
        let clothes = getCloth(clothIDs: idArray)
        
        let clothInstance = Cloth()
        let clothesWithClothType = clothInstance.getClothesObjectsForUI(clothesFromStorage: clothes)
        
        return clothesWithClothType
        
    }
    
    func getNumberOfExistingSets() -> Int{
        
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ClothesSet")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id > 1")
        var count = 0
        
        do{
            count = try context.count(for: fetchRequest)
        }
        catch {
            print("could not fetch count")
        }

        return count
        
    }
    
    public func getAllClothingSets()->[ClothesSet]?{
    
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ClothesSet")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id > 1")
        
        var fetchedSets:[ClothesSet]
        
        do {
            fetchedSets = try context.fetch(fetchRequest) as! [ClothesSet]
            return fetchedSets
        } catch {
            fatalError("Failed to fetch: \(error)")
            
        }

        return nil
    
    }
    
    func getCurrentClothingSet(gender:Int16)->[Clothes]?{
        
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ClothesSet")
        fetchRequest.returnsObjectsAsFaults = false

        let condition = true
        fetchRequest.predicate = NSPredicate(format: "isCurrent == true AND gender == \(gender)")
        
        let fetchedSet:[ClothesSet]
        
        do {
            fetchedSet = try context.fetch(fetchRequest) as! [ClothesSet]
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
        
        let clothesIds:NSArray
        
        if fetchedSet.count == 1 {
            clothesIds = NSKeyedUnarchiver.unarchiveObject(with: fetchedSet[0].clothesIds as! Data) as! NSArray
            
            //Next step retrieve Clothes with that IDs and return Array
            if clothesIds.count > 0 {
                
                let clothes = getCloth(clothIDs: clothesIds as! [Int])
            
                if clothes.count > 0{
                    return clothes
                }
                else{
                    return nil
                }
            }else{
                return nil
            }
        }
        else{
            return nil
        }
        

    }
    
    func getCloth(clothIDs:[Int])->[Clothes]{
    
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Clothes")
        fetchRequest.returnsObjectsAsFaults = false
        
        let condition = clothIDs
        fetchRequest.predicate = NSPredicate(format: "id IN %@", condition as CVarArg)

        let fetchedClothes:[Clothes]
        
        do {
            fetchedClothes = try context.fetch(fetchRequest) as! [Clothes]
        } catch {
            fatalError("Failed to fetch: \(error)")
        }

        return fetchedClothes
    }
    
    func changeClothesSetToCurrent(setId:Int){
        
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ClothesSet")
        fetchRequest.returnsObjectsAsFaults = false
        
        let condition = true
        fetchRequest.predicate = NSPredicate(format: "isCurrent == %@", condition as CVarArg)
        //Set all sets to NOT current
        do {
            let fetchedSet = try context.fetch(fetchRequest)
        
            for result in fetchedSet as! [NSManagedObject]{
        
                do {
                    result.setValue(false, forKey: "isCurrent")
                    try context.save()
                } catch {
                    fatalError("Failed change to not current: \(error)")
                }
            }
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
        
        //Set the new set as current
        //let condition2 = setId
        fetchRequest.predicate = NSPredicate(format: "id == %d",setId)
        
        do {
            let fetchedSet = try context.fetch(fetchRequest)
            
            for result in fetchedSet as! [NSManagedObject]{
                
                do {
                    result.setValue(true, forKey: "isCurrent")
                    try context.save()
                    print("Sucessfully changed set \(setId) to current")
                } catch {
                    fatalError("Failed change to current: \(error)")
                }
            }
        } catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
    
    func getContext()->NSManagedObjectContext{
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        return context
    }

    
}
