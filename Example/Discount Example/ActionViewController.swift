//
//  ActionViewController.swift
//  Discount Example
//
//  Created by Thomas Carey on 8/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MobileCoreServices
import VendRegisterExtension

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                
                if provider.hasItemConformingToTypeIdentifier("com.vendhq.uti-sale") {
                    
                    provider.loadItem(forTypeIdentifier: "com.vendhq.uti-sale", options: nil, completionHandler: { (secureCoding, error) in
                        
                        guard let secureCoding = secureCoding else { return }
                        
                        if let data = secureCoding as? Data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                if let jsonDict = json as? [String : Any] {
                                    if let saleJson = jsonDict["payload"] as? [String: Any] {
                                        let sale = try Sale.decode(saleJson)
                                        print("Got my sale: \(sale)")
                                        
                                    }
                                    
                                    //print("Got sale data: \(json)")
                                }
                                
                            } catch {
                                print("Awesome error: \(error)")
                            }
                            
                        }
                        
                    })
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
