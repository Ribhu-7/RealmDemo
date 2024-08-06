//
//  Extension.swift
//  RealmDB
//
//  Created by Apple on 06/08/24.
//

import Foundation
import UIKit
import RealmSwift

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
                cell.textLabel?.text = contactArray[indexPath.row].firstName
                cell.detailTextLabel?.text = contactArray[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit"){
            _,_,_ in
            self.contactConfig(isAdd: false, index: indexPath.row)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete"){
            _,_,_ in
            DatabaseHelper.shared.deleteContact(contact: self.contactArray[indexPath.row])
            self.contactArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        edit.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [edit,delete])
        return swipeAction
        
    }
    
    func contactConfig(isAdd: Bool, index: Int){
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ? "Please enter your contact details" : "Please update your contact details" , preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default){
            _ in
            if let firstName = alertController.textFields?.first?.text,
               let lastName = alertController.textFields?[1].text {
                let contact = Contact(firstName: firstName, lastName: lastName)
                if isAdd {
                    self.contactArray.append(contact)
                    DatabaseHelper.shared.saveContact(contact: contact)
                } else {
                    //self.contactArray[index] = contact
                    DatabaseHelper.shared.updateContact(oldContact: self.contactArray[index], newContact: contact)
                }
                
                self.tableView.reloadData()
                //print(firstName,lastName)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField{
            firstNameField in
            
            firstNameField.placeholder = isAdd ? "Enter your firstname" : self.contactArray[index].firstName
            
        }
        alertController.addTextField{
            lastNameField in
            lastNameField.placeholder = isAdd ? "Enter your lastname" : self.contactArray[index].lastName
        }
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController,animated: true)
        
    }
}

