//
//  ShowRating+CoreDataProperties.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//
//

import Foundation
import CoreData


extension ShowRating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShowRating> {
        return NSFetchRequest<ShowRating>(entityName: "ShowRating")
    }

    @NSManaged public var id: String?
    @NSManaged public var rating: String?

}

extension ShowRating : Identifiable {

}
