//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    //Creating Firebase instance / Other config was used on the AppDelegate
    let db = Firestore.firestore()
    //instance of the Messsge type that we needed to populate TV
    var messages: [Message] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self //setting the datasource property
        super.viewDidLoad()
        //hiding the back button.
        navigationItem.hidesBackButton = true
        //tapping to the title of the navigation bar
        title = K.appTitle
        
        //First create a custom cell with (UITableViewCell type) and the .xib file with the cocoa touchclass file, transform the cell the design you want.
        //after designing the cell, name it on the identifier property of the cell.
        //after creating and designing it, the last thing is to register it, like below, so that it can be used on the code.
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages () {
        db.collection(K.FStore.collectionName)//formating on each line for better visualization
            .order(by: K.FStore.timeStamp)//using the timestamp to organize the messages ascend or descend
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error {
                print("the data call got an error: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {//an array of documents
                    for doc in snapshotDocuments {//iterating on the array of Documents to get document
                        let data = doc.data()//access to the data \/
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {//forcedowncast from any to String
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            //Append to messages. TV uses massages to populate cells.
                            //update Tableview Async
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                //moviment to scrolldown down (tableview)
                                //First create an indexpath to comand the scroll on the line below that.
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //the Auth.auth().currentUser?.email is used to call Firestore for the email of the user loggedIn
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [//here is necessary to name the colection where data is going to get stored
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                //the timestamp is beeing sent for further organization (sort)
                K.FStore.timeStamp: Date().timeIntervalSince1970
            ]) { error in//This is the completion handler of the comand addDocument
                if let e = error {
                    print("error while saving message: \(e)")
                } else {
                    print("success on saving message on firesore")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }                    
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()//added just to make the code more redable.
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - Populating tableView
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //transforming the array of massages [Message] into Message (With sender and body propertys, each with their values)
        let message = messages[indexPath.row]
        let sender = message.sender
        
        //creating cell of identity (k.cellIdentifier), of type MessageCell, so that we can change stuff on it (Label, view, imageview)
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body// chage the value of MessageCell IBOutlet
        
        if sender == Auth.auth().currentUser?.email {//checking if message were sent for the user logedIn
            //diferenciating the massageCell. Sent or received message
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            return cell
        } else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            return cell
        }
    }
}
