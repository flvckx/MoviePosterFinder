//
//  CoreDataStack.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import CoreData

protocol CoreDataStackManager {
    var managedContext: NSManagedObjectContext { get }
    
    init(modelName: String)
    
    func saveContext()
}

class CoreDataStack: CoreDataStackManager {
    
    private let modelName: String
    
    required init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                
            }
        })
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }
        
        do {
            try managedContext.save()
        } catch let error {
            // send error details
        }
    }
}
