//
//  ViewController.swift
//  PassManageUsingSDK
//
//  Created by Uday on 28/02/21.
//

import UIKit
import PasswordManagerSDK
import UniformTypeIdentifiers

class ViewController: UIViewController {
    
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    var importedDocUrl: URL = URL(string: "www.google.com")!

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
//        if let creds = PlistManager.fetch(){
//            print(creds.first?.password)
//        }
    }
    
    
    @IBAction func importButtonAction(_ sender: UIButton){
        DocumentPicker.openDocumentPicker(controller: self, delegate: self)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton){
        DocumentPicker.shareDocument(controller: self, fileURL: importedDocUrl)
    }
    
    @IBAction func jsonButtonAction(_ sender: UIButton){
        
        //to fetch as Dict
//        let jsonArray = PlistManager.fetchAsDict()
//        print(jsonArray)
        
        //to fetch as json
        let jsonArray = PlistManager.fetchAsDict()
        print(jsonArray)
    }
    
    
    @IBAction func importfromjsonString(_ sender: UIButton){
        let string =  "{\"id\":\"A58C7117-18A1-4111-9890-A31F51140482\",\"password\":\"password\",\"domain\":\"wwww.fb.com\",\"appWebUrl\":\"\",\"userName\":\"facebook2\",\"platform\":\"facebook\",\"appPackageName\":\"\",\"appName\":\"\",\"domainName\":\"\",\"timeStamp\":\"\"}"
        PlistManager.writeWithJsons(jsonStringArray: [string])
        print( PlistManager.fetchAsJson())
    }
    
}


///MARK: - document picker
extension ViewController: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard controller.documentPickerMode == .import, let url = urls.first else { return }
        self.importedDocUrl = url
        if let strData = try? String(contentsOf: url) {
            /// get data of document in terms of string
            print(strData)
        }
        controller.dismiss(animated: true)
    }
}
