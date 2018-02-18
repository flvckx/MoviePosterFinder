//
//  Movie+CoreDataClass.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//
//

import Foundation
import CoreData

fileprivate var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
}()

@objc(Movie)
public class Movie: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Title"
        case releasedDate = "Released"
        case image = "Poster"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
                fatalError("Failed to decode Movie!")
                
        }
        
        self.init(entity: entity, insertInto: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        image = try values.decode(String.self, forKey: .image)
        
        let released = try values.decode(String.self, forKey: .releasedDate)
        releasedDate = dateFormatter.date(from: released) as NSDate?
    }
}
