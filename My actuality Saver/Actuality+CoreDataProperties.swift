//
//  Actuality+CoreDataProperties.swift
//  My actuality Saver
//
//  Created by Philippe Donael Essono on 05/12/2018.
//  Copyright © 2018 Philippe Donael Essono. All rights reserved.
//
//

import Foundation
import CoreData


extension Actuality {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Actuality> {
        return NSFetchRequest<Actuality>(entityName: "Actuality")
    }

    @NSManaged public var name: String?
    @NSManaged public var actuality: String?
    @NSManaged public var actualityType: String?

}
