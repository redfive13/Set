//
//  Table.swift
//  Set
//
//  Created by Larry Scherr on 11/10/23.
//

import Foundation

//struct Table<Item> where Item: Equatable {
//    var items = [Item?]()
//    
//    var itemsOnTable: [Item?] {
//        return items
//    }
//    
//    mutating func putOnTable(_ item: Item) {
//        if let index = items.firstIndex(where: { $0 == nil }) {
//            items[index] = item
//        } else {
//            items.append(item)
//        }
//    }
//    
//    mutating func removeFromTable(_ item: Item) {
//        if let index = items.firstIndex(where: { $0 == item }) {
//            items[index] = nil
//        }
//    }
//    
//    mutating func compactItems() {
//        items = items.filter { $0 != nil }
//    }
//}
