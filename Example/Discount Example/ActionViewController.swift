//
//  ActionViewController.swift
//  Discount Example
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
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
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var mergeSaleButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                
                if provider.hasItemConformingToTypeIdentifier(vendRegisterExtensionFileType) {
                    
                    provider.loadItem(forTypeIdentifier: vendRegisterExtensionFileType, options: nil, completionHandler: { (secureCoding, error) in
                        
                        guard let secureCoding = secureCoding else { return }
                        
                        if let data = secureCoding as? Data {
                            do {
                                let decoder = JSONDecoder()
                                
                                if let jsonString = String.init(data: data, encoding: String.Encoding.utf8) {
                                    print("Got this JSON from VendRegister: \(jsonString)")
                                }
                                
                                let root = try decoder.decode(Root.self, from: data)
                                
                                // A good citizen should determine which operations are supported by the current installation and respond accordingly
                                // In this case we are enabling the button to add an item based on whether the .addLineItems operation is supported
                                self.addItemButton.isEnabled = VendRegisterExtensionOperationName.availableOperations(api: root.version).contains(.addLineItems)
                                
                                self.mergeSaleButton.isEnabled = VendRegisterExtensionOperationName.availableOperations(api: root.version).contains(.mergeSale)
                                
                                self.sale = root.payload.sale
                                print("Got my sale: \(root.payload.sale)")
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
    
    @IBAction func mergeSale(_ sender: Any) {
        guard var sale = sale else { return }
        
        sale.note = "Hello from Discount Example"
        
        if sale.lineItems.count > 0 {
            sale.lineItems[0].note = "Hello to the first line item"
            sale.lineItems[0].unitPrice = NSDecimalNumber(string: "2.25")
        }
        
        self.extensionContext?.completeRequest(returningItems: [VendRegisterExtensionOperation.mergeSale(sale).extensionItem], completionHandler: nil)
        
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
            cell.costLabel.text = lineItem.priceIsTaxInclusive ? "\(lineItem.unitPrice)" : "\(lineItem.unitPrice.adding(lineItem.unitTax))"
            
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
