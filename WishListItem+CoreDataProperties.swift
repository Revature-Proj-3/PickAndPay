//
//  WishListItem+CoreDataProperties.swift
//  PickAndPay
//
//  Created by admin on 7/7/22.
//
//

import Foundation
import CoreData


extension WishListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishListItem> {
        return NSFetchRequest<WishListItem>(entityName: "HistoryItem")
    }

    @NSManaged public var category: String?
    @NSManaged public var count: Int32
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var rate: Int32
    @NSManaged public var title: String?
    @NSManaged public var user: User?

}

extension WishListItem : Identifiable {

}
