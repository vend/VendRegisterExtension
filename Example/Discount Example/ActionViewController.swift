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

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sale: Sale? {
        didSet {
            if let tableView = tableView {
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                
                if provider.hasItemConformingToTypeIdentifier(vendRegsiterExtensionFileType) {
                    
                    provider.loadItem(forTypeIdentifier: vendRegsiterExtensionFileType, options: nil, completionHandler: { (secureCoding, error) in
                        
                        guard let secureCoding = secureCoding else { return }
                        
                        if let data = secureCoding as? Data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                if let jsonDict = json as? [String : Any] {
                                    if let saleJson = jsonDict["payload"] as? [String: Any] {
                                        let sale = try Sale.decode(saleJson)
                                        print("Got my sale: \(sale)")
                                        self.sale = sale
                                    }
                                }
                                
                            } catch {
                                print("Error: \(error)")
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
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }

    @IBAction func addItem(_ sender: Any) {
        guard let sale = sale else { return }

        if let item = sale.lineItems.last {
            self.extensionContext?.completeRequest(returningItems: [VendRegisterExtensionOperation.addLineItems([item]).extensionItem], completionHandler: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sale = sale else { return 0 }
        switch section {
        case 0: return sale.lineItems.count
        case 1: return 1;
        default: return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sale = sale else { fatalError() }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LineItemCell", for: indexPath) as! LineItemCell
            
            let lineItem = sale.lineItems[indexPath.row]
            cell.quantityLabel.text = "\(lineItem.quantity)"
            cell.itemLabel.text = lineItem.name
            cell.costLabel.text = "\(lineItem.unitPrice + lineItem.unitTax)"
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCostCell", for: indexPath) as! TotalCostCell
            cell.costLabel.text = "\(sale.totals.price)"
            return cell
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Line Items"
        case 1: return "Totals"
        default: return nil
        }
    }
}
