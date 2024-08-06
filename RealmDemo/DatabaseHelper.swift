//
//  DatabaseHelper.swift
//  RealmDemo
//
//  Created by Apple on 06/08/24.
//

import Foundation
import RealmSwift
import UIKit

class DatabaseHelper {
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    func getDatabaseURL() -> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveContact(contact: Contact){
        try! realm.write{
            realm.add(contact)
        }
    }
    
    func getAllContacts() -> [Contact]{
        return Array(realm.objects(Contact.self))
    }
    
    func updateContact(oldContact: Contact , newContact: Contact){
        try! realm.write{
            oldContact.firstName = newContact.firstName
            oldContact.lastName = newContact.lastName
        }
    }
    
    func deleteContact(contact: Contact){
        try! realm.write{
            realm.delete(contact)
        }
    }
}
