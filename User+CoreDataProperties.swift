//
//  User+CoreDataProperties.swift
//  PickAndPay
//
//  Created by admin on 7/7/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var balance: Double
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var historyItem: NSSet?
    @NSManaged public var shoppingCartItem: NSSet?
    @NSManaged public var wishListItem: NSSet?

}

// MARK: Generated accessors for historyItem
extension User {

    @objc(addHistoryItemObject:)
    @NSManaged public func addToHistoryItem(_ value: WishListItem)

    @objc(removeHistoryItemObject:)
    @NSManaged public func removeFromHistoryItem(_ value: WishListItem)

    @objc(addHistoryItem:)
    @NSManaged public func addToHistoryItem(_ values: NSSet)

    @objc(removeHistoryItem:)
    @NSManaged public func removeFromHistoryItem(_ values: NSSet)

}

// MARK: Generated accessors for shoppingCartItem
extension User {

    @objc(addShoppingCartItemObject:)
    @NSManaged public func addToShoppingCartItem(_ value: ShoppingCartItem)

    @objc(removeShoppingCartItemObject:)
    @NSManaged public func removeFromShoppingCartItem(_ value: ShoppingCartItem)

    @objc(addShoppingCartItem:)
    @NSManaged public func addToShoppingCartItem(_ values: NSSet)

    @objc(removeShoppingCartItem:)
    @NSManaged public func removeFromShoppingCartItem(_ values: NSSet)

}

// MARK: Generated accessors for wishListItem
extension User {

    @objc(addWishListItemObject:)
    @NSManaged public func addToWishListItem(_ value: WishListItem)

    @objc(removeWishListItemObject:)
    @NSManaged public func removeFromWishListItem(_ value: WishListItem)

    @objc(addWishListItem:)
    @NSManaged public func addToWishListItem(_ values: NSSet)

    @objc(removeWishListItem:)
    @NSManaged public func removeFromWishListItem(_ values: NSSet)

}

extension User : Identifiable {

}
