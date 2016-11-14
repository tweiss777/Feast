//
//  ShareLocationVC.swift
//  HackathonProject
//
//  Created by Tal Weiss on 11/11/16.
//  Copyright © 2016 Tal Weiss. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
//IGNORE THIS CLASS
class ShareLocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //CODE BEING ADDED 
    func findContacts() -> [CNContact]{
        //fetches and displays the phones contacts
        let store = CNContactStore()
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactImageDataKey,CNContactPhoneNumbersKey] as [Any]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        
        var contacts = [CNContact]()
        
        do{
            try store.enumerateContacts(with: fetchRequest, usingBlock: {( contact, stop) -> Void in
                contacts.append(contact)
            })
        }
        
        catch let Error as NSError{
            print(Error.localizedDescription)
        }
        
        return contacts
    }
    


}
