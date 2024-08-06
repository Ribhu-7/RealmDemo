//
//  ViewController.swift
//  RealmDemo
//
//  Created by Apple on 06/08/24.
//

import UIKit
import RealmSwift

class Contact: Object{
   @Persisted var firstName: String
   @Persisted var lastName: String
    
    convenience init(firstName: String, lastName: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var contactArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configuration()
    }

    @IBAction func addContact(_ sender: UIBarButtonItem) {
        contactConfig(isAdd: true, index: 0)
    }
    
}

extension ViewController{
    func configuration(){
        contactArray = DatabaseHelper.shared.getAllContacts()
    }
    
    
}
