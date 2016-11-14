//
//  SharelocationTableViewController.swift
//  HackathonProject
//
//  Created by Tal Weiss on 11/11/16.
//  Copyright © 2016 Tal Weiss. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class SharelocationTableViewController: UITableViewController {
    var contacts = [CNContact]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.contacts = self.findContacts()
            
            DispatchQueue.main.async {
                // Do main UI work
                self.tableView!.reloadData()
            }
            

        
        }
        
        


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.contacts.count
    }
    
    
//    @IBOutlet weak var ContactImageView: UIImageView!
//    @IBOutlet weak var contactNameLabel: UILabel!
//    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    
    
    
    
    
    //SHOULD BE IN CONFIGURE VIEW FUNCTION
    
    
    
    
    
    
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

    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let contact = contacts[indexPath.row] as CNContact
        cell.textLabel!.text = "\(contact.givenName) \(contact.familyName)"
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
