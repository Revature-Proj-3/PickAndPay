//
//  SearchBarDelegateFile.swift
//  PickAndPay
//
//  Created by admin on 7/8/22.
//

import Foundation
import UIKit

class SearchBarDelegateFile {
    static var searchHelper = SearchBarDelegateFile()
    
    func findSearchItems(_ arr : [Product],_ searchTerm : String) -> [Product] {
        var foundItems : [Product] = []
        for item in arr {
            if(item.title.lowercased().contains(searchTerm.lowercased())){
                foundItems.append(item)
            }
        }
        return foundItems
    }

}
