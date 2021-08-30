//
//  StorageManager.swift
//  MyPlaces
//
//  Created by кирилл ларионов on 06.08.2021.
//

import RealmSwift

let realm = try! Realm()


class StorageManager{
    
    static func saveOject(_ place: Place){
        try! realm.write{
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place){
        try! realm.write
        {
            realm.delete(place)
        }
    }
}
