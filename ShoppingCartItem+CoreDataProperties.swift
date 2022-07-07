//
//  ShoppingCartItem+CoreDataProperties.swift
//  PickAndPay
//
//  Created by admin on 7/7/22.
//
//

import Foundation
import CoreData


extension ShoppingCartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCartItem> {
        return NSFetchRequest<ShoppingCartItem>(entityName: "ShoppingCartItem")
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

extension ShoppingCartItem : Identifiable {

}
