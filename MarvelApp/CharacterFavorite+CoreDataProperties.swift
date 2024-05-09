//
//  CharacterFavorite+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Juan Pablo Alvarez Loran on 07/05/24.
//
//

import Foundation
import CoreData


extension CharacterFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterFavorite> {
        return NSFetchRequest<CharacterFavorite>(entityName: "CharacterFavorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var thumbnail: String?

}

extension CharacterFavorite : Identifiable {

}
