//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Hayner Esteves on 28/08/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//


struct K {
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appTitle = "⚡️FlashChat"
    static let forgotEmail = "Add an E-mail"
    static let forgotPassword = "Add a password"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let bodyField = "body"
        static let senderField = "sender"
        static let timeStamp = "date"
    }
}
