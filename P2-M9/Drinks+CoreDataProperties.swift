//
//  Drinks+CoreDataProperties.swift
//  P2-M9
//
//  Created by Juan Pablo Alvarez Loran on 18/07/24.
//
//

import Foundation
import CoreData


extension Drinks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drinks> {
        return NSFetchRequest<Drinks>(entityName: "Drinks")
    }

    @NSManaged public var name: String?
    @NSManaged public var directions: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var img: String?

}

extension Drinks : Identifiable {

}
