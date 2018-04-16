//
//  MovieProvider.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import CoreData

protocol MovieProviderManager {
    func findInStorage(_ path: String) -> Movie?
    func decodeToStorage(_ data: Data, urlPath: String) throws -> Movie
}

class MovieProvider: MovieProviderManager {
    
    private var managedContext: NSManagedObjectContext {
        return AppDelegate.coreDataStack.managedContext
    }
    
    func findInStorage(_ path: String) -> Movie? {
        let movieFetch: NSFetchRequest<Movie> = Movie.fetchRequest()
        movieFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Movie.pathURL), path)
        
        do {
            let results = try managedContext.fetch(movieFetch)
            
            if results.count > 0 {
                let movie = results.first
                movie?.addDate(managedContext)
                
                try managedContext.save()
                
                return movie
            } else {
                return nil
            }
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        return nil
    }
    
    func decodeToStorage(_ data: Data, urlPath: String) throws -> Movie {
        let decoder = JSONDecoder()
        
        let movie = try decoder.decode(Movie.self, from: data)
        movie.pathURL = urlPath
        
        try managedContext.save()
        
        return movie
    }
}
