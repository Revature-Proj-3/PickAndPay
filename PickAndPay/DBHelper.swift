//
//  DBHelper.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/7/22.
//

import Foundation
import UIKit
import CoreData

class DBHelper {
    
    static var dbHelper = DBHelper()
    var user = [User]()
    let userDefault = UserDefaults.standard
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    init(){
        setUser()
    }

    func createUser(_ name : String,_ email : String,_ phoneNumber : String,_ password : String){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.name = name
        user.email = email
        user.phoneNumber = phoneNumber
        user.password = password
        user.balance = 0.00
        do{
            try context?.save()
        } catch{
            print("Error saving user")
        }
    }
    
    func getUserData(_ email : String) -> User{
        setUser()
        var user = User()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1
        do{
            let req = try context?.fetch(fetchRequest) as! [User]
            if(req.count != 0){
                user = req.first!
            } else{
                print("No user by that name")
            }
        } catch {
            print("error getting user data")
        }
        return user
    }
    
    func checkIfUserExists(_ email : String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1
        do{
            let req = try context?.fetch(fetchRequest) as! [User]
            if(req.count != 0){
                return true
            } else{
                print("No user by that name")
                return false
            }
        } catch {
            print("error getting user data")
        }
        return false
    }
    
    func setUser(){
        let email = userDefault.string(forKey: "currentLoggedIn")
        do{
            let request = User.fetchRequest() as NSFetchRequest<User>
            let pred = NSPredicate(format:"email == %@", email!)
            request.predicate = pred
            let userArr = try context?.fetch(request)
            user = userArr!
        } catch{
            print("error getting user")
        }
    }
    
    
    func addHistoryItem(_ title : String,_ productDescription : String,_ image : String,_ category : String,_ price : Double,_ rate : Int32,_ count : Int32){
        setUser()
        do{
            let historyItem = HistoryItem(context: context!)
            historyItem.title = title
            historyItem.productDescription = productDescription
            historyItem.image = image
            historyItem.category = category
            historyItem.price = price
            historyItem.rate = rate
            historyItem.count = count
            user.first?.addToHistoryItem(historyItem)
            try context?.save()
        } catch{
            print("Error saving History Item")
        }
    }
    
    func getAllHistoryItem() -> [HistoryItem]{
        setUser()
        return user.first?.historyItem?.allObjects as! [HistoryItem]
    }
   
    func deleteHistoryItem(_ title : String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryItem")
        fetchRequest.predicate = NSPredicate(format:"title == %@",title)
        do{
            let historyItem = try context?.fetch(fetchRequest)
                context?.delete(historyItem?.first as! HistoryItem)
                try context?.save()
        } catch{
            print("Error deleting History Item")
        }
    }
    
    func addShoppingCartItem(_ title : String,_ productDescription : String,_ image : String,_ category : String,_ price : Double,_ rate : Int32,_ count : Int32){
        setUser()
        do{
            let shoppingCartItem = ShoppingCartItem(context: context!)
            shoppingCartItem.title = title
            shoppingCartItem.productDescription = productDescription
            shoppingCartItem.image = image
            shoppingCartItem.category = category
            shoppingCartItem.price = price
            shoppingCartItem.rate = rate
            shoppingCartItem.count = count
            user.first?.addToShoppingCartItem(shoppingCartItem)
            try context?.save()
        } catch{
            print("Error saving ShoppingCart Item")
        }
    }
    
    func getAllShoppingCartItem() -> [ShoppingCartItem] {
        setUser()
        return user.first?.shoppingCartItem?.allObjects as? [ShoppingCartItem] ?? []
    }
    
    func deleteShoppingCartItem(_ title : String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingCartItem")
        fetchRequest.predicate = NSPredicate(format:"title == %@",title)
        do{
            let shoppingCartItem = try context?.fetch(fetchRequest)
                context?.delete(shoppingCartItem?.first as! ShoppingCartItem)
                try context?.save()
                
        } catch{
            print("Error deleting ShoppingCart Item")
        }
    }
    
    func addWishListItem(_ title : String,_ productDescription : String,_ image : String,_ category : String,_ price : Double,_ rate : Int32,_ count : Int32){
        setUser()
        do{
            print(user.first)
            let wishListItem = WishListItem(context: context!)
            wishListItem.title = title
            wishListItem.productDescription = productDescription
            wishListItem.image = image
            wishListItem.category = category
            wishListItem.price = price
            wishListItem.rate = rate
            wishListItem.count = count
            user.first?.addToWishListItem(wishListItem)
            try context?.save()
            print("data from wishlistItem", wishListItem)
           
        } catch{
            print("Error saving WishList Item")
        }
    }
  
    func getWishListItem() -> [WishListItem]{
        setUser()
        return user.first?.wishListItem?.allObjects as? [WishListItem] ?? []
    }
    
    func deleteWishListItem(_ title : String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishListItem")
        fetchRequest.predicate = NSPredicate(format:"title == %@",title)
        do{
            let wishListItem = try context?.fetch(fetchRequest)
                context?.delete(wishListItem?.first as! WishListItem)
                try context?.save()
        } catch{
            print("Error deleting WishList Item")
        }
    }
    
}
