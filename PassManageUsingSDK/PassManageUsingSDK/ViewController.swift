//
//  ViewController.swift
//  PassManageUsingSDK
//
//  Created by Uday on 28/02/21.
//

import UIKit
import PasswordManagerSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to remove all from local stored passwords from plist file
        PlistManager.removeAll()
        
        //create new credential
        let cred = Credential(domain: "www.fb.com", userName: "facebook", password: "facebokPassword", platform: "facebook")
         PlistManager.write(cred: cred)
        
        
        //fetch all creds from local Plist file
        if let creds = PlistManager.fetch(){
            if let firstCred = creds.first{
                
                ///update password
                firstCred.password = "updated password"
                PlistManager.edit(cred: firstCred)
            }
        }
        
        ///check password has been updated
        if let creds = PlistManager.fetch(){
            print(creds.first?.password)
        }
        
        
    }


}

