//
//  SearchDateProvider.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import CoreData

class SearchDateProvider {
    private var managedContext: NSManagedObjectContext {
        return AppDelegate.coreDataStack.managedContext
    }
    
    func getAll(completion: @escaping (_ searchDates: [SearchDate]?) -> Void) {
        let asyncFetchRequest = NSAsynchronousFetchRequest<SearchDate>(fetchRequest: SearchDate.fetchRequest()) { (result) in
            if let dates = result.finalResult {
                completion(dates.sorted { return $0.date! as Date > $1.date! as Date} )
            }
        }
        
        do {
            try managedContext.execute(asyncFetchRequest)
        } catch _ {
        }
    }
}
