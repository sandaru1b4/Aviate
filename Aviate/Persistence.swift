//
//  Persistence.swift
//  Aviate
//
//  Created by Admin on 2025-05-27.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Aviate")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
}

extension PersistenceController {
    @discardableResult
    func saveUserData(with user: User) -> LocalUserData? {
        let context = PersistenceController.shared.mainContext
        
        let entity = LocalUserData.entity()
        let userData = LocalUserData(entity: entity, insertInto: context)
        
        userData.timestamp = Date()
        userData.fullName = user.fullName
        userData.email = user.email
        
        do {
            try context.save()
            return userData
        } catch let error {
            debugPrint("Error: \(error)")
        }
        
        return nil
    }
    
    func loadUserData() -> LocalUserData? {
        let mainContext = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            let result = try mainContext.fetch(fetchRequest).first
            return result
        }
        catch {
            debugPrint(error)
        }
        
        return nil
    }
    
    func updateUserData(with user: User) {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            guard let userData = try context.fetch(fetchRequest).first else { return }
            
            userData.timestamp = Date()
            userData.fullName = user.fullName
            userData.email = user.email
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func deleteUserData() {
        let context = PersistenceController.shared.mainContext
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            let userData = try context.fetch(fetchRequest)
            userData.forEach{ context.delete($0) }
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
}
