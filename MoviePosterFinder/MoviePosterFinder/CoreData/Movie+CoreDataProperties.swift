//
//  Movie+CoreDataProperties.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var name: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var image: String?
    @NSManaged public var searchDates: NSSet?

}

// MARK: Generated accessors for searchDates
extension Movie {

    @objc(addSearchDatesObject:)
    @NSManaged public func addToSearchDates(_ value: SearchDate)

    @objc(removeSearchDatesObject:)
    @NSManaged public func removeFromSearchDates(_ value: SearchDate)

    @objc(addSearchDates:)
    @NSManaged public func addToSearchDates(_ values: NSSet)

    @objc(removeSearchDates:)
    @NSManaged public func removeFromSearchDates(_ values: NSSet)

}
