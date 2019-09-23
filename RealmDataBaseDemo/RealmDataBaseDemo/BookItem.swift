//
//  BookItem.swift
//  RealmDataBaseDemo
//
//  Created by Boss on 9/23/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import Foundation
import RealmSwift

//Class BookItem thừa kế từ class Object. Class Object này là một class của Realm, với khai báo này chúng ta giúp Realm hiểu rằng BookItem là một Realm Object, và BookItem phải được khai báo là @objcMembers

@objcMembers class BookItem: Object{
    enum Property: String {
        case id, name, isCompleted
    }
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var isCompleted = false
    
    override static func primaryKey() -> String? {
        return BookItem.Property.id.rawValue
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}

extension BookItem{
    static func add(name: String, in realm: Realm = try! Realm()) -> BookItem{
        let book = BookItem(name)
        try! realm.write {
            realm.add(book)
        }
        return book
    }
    static func getAll(in realm: Realm = try! Realm()) -> Results<BookItem> {
        return realm.objects(BookItem.self)
            .sorted(byKeyPath: BookItem.Property.isCompleted.rawValue)
    }
    
    func toggleCompleted() {
        guard let realm = realm else { return }
        try! realm.write {
            isCompleted = !isCompleted
        }
    }
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
