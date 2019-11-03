//
//  DataController.swift
//  Mooskine
//
//  Created by kant on 28.02.2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext!
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
//        let backgroundContext = perstistentContainer.newBackgroundContext()
//
//        perstistentContainer.performBackgroundTask { (contex) in
//            doSomeSlowWork()
//            try? contex.save()
//        }
//
//        viewContext.perform {
//            doSomeWork()
//        }
//
//        viewContext.performAndWait {
//            soSomeWork()
//        }
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autosaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
    
    func autosaveViewContext(interval: TimeInterval = 30) {
        print("autosaving")
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autosaveViewContext(interval: interval)
        }
    }
    
    func configureContexts(){
        backgroundContext = persistentContainer.newBackgroundContext()
        
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
}
