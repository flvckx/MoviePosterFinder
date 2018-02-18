//
//  SearchDate+CoreDataProperties.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//
//

import Foundation
import CoreData


extension SearchDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchDate> {
        return NSFetchRequest<SearchDate>(entityName: "SearchDate")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var movie: Movie?

}
