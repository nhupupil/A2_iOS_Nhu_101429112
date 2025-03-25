//
//  SecondViewController.swift
//  A2_iOS_ Nhu_101429112
//
//  Created by Huynh Yen Nhu Ly on 2025-03-24.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var providerTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func submitForm(_ sender: UIButton) {
        var id = idTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let desc = descTextField.text ?? ""
        let priceString = priceTextField.text ?? ""
        let provider = providerTextField.text ?? ""
        
        
        // Validate input fields
        if name.isEmpty {
            showAlert(title: "Error", message: "Product name cannot be empty.")
            return
        }
        
        if desc.isEmpty {
            showAlert(title: "Error", message: "Product description cannot be empty.")
            return
        }
        guard let price = Double(priceString), price > 0 else {
            // If price is not valid, show an error alert
            showAlert(title: "Error", message: "Please enter a valid price greater than 0.")
            return
        }
        
        // Auto-generate ID if empty
          if id.isEmpty || isProductIDExists(id) {
              id = generateUniqueProductID()
              showAlert(title: "Notice", message: "The provided ID already exists or was empty. A new ID (\(id)) has been generated.")
          }
        
        let product = Product(context: context)
        product.id = id
        product.name = name
        product.desc = desc
        price > 0 ? product.price = price : ()
        product.provider = provider
        
        products.append(product)
        
        saveProduct()
        
        // Show confirmation alert
        showAlert(title: "Success", message: "Product submitted successfully!")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add an action (button) to dismiss the alert
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func saveProduct() {
        do {
            try context.save()
        } catch {
            print("Error saving new product: \(error)")
        }
    }
    
    // Function to generate a unique product ID
    func generateUniqueProductID() -> String {
        var newID: String
        repeat {
            let randomNum = Int.random(in: 10...9999)
            newID = "P\(randomNum)"
        } while isProductIDExists(newID)  // Keep generating until a unique ID is found
        return newID
    }
    
    // Function to check if product ID already exists in Core Data
    func isProductIDExists(_ id: String) -> Bool {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let matchingProducts = try context.fetch(fetchRequest)
            return !matchingProducts.isEmpty
        } catch {
            print("Error checking product ID: \(error)")
            return false
        }
    }}
