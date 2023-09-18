//
//  Favourite+CoreDataProperties.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 18/9/2023.
//
//

import Foundation
import CoreData

extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var color: String?
    @NSManaged public var iconUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var symbol: String?
    @NSManaged public var uuid: String?
}

extension Favourite: Identifiable {

}
