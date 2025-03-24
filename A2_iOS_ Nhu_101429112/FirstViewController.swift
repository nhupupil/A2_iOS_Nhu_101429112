//
//  ViewController.swift
//  A2_iOS_ Nhu_101429112
//
//  Created by Huynh Yen Nhu Ly on 2025-03-24.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    
    @IBOutlet private var textFields: [UITextField]!
    
    var currentProductIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        seedProductsIfNeeded()
        
        // Fetch products if they are not already loaded
        if products.isEmpty {
            fetchProducts()
        }
        
        if let firstProduct = fetchFirstProduct() {
            displayProduct(firstProduct)
        }
        
        
    }
    //Seed 10 products if none exists
    func seedProductsIfNeeded() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 { // Only seed if no products exist
                let products = [
                    ("P001", "Laptop", "High-performance laptop", 999.99, "TechCorp"),
                    ("P002", "Smartphone", "Latest smartphone model", 799.99, "Mobile Inc."),
                    ("P003", "Headphones", "Noise-canceling headphones", 199.99, "AudioTech"),
                    ("P004", "Smartwatch", "Fitness tracking smartwatch", 249.99, "WearableTech"),
                    ("P005", "Tablet", "Lightweight and portable tablet", 599.99, "GigaTab"),
                    ("P006", "Camera", "Professional DSLR camera", 1299.99, "PhotoGear"),
                    ("P007", "Gaming Console", "Next-gen gaming console", 499.99, "GameWorld"),
                    ("P008", "Monitor", "4K UHD monitor", 349.99, "DisplayMax"),
                    ("P009", "Keyboard", "Mechanical keyboard with RGB", 129.99, "Keytron"),
                    ("P010", "Mouse", "Ergonomic wireless mouse", 79.99, "TechMouse")
                ]
                
                for product in products {
                    let newProduct = Product(context: context)
                    newProduct.id = product.0
                    newProduct.name = product.1
                    newProduct.desc = product.2
                    newProduct.price = product.3
                    newProduct.provider = product.4
                }
                
                try context.save()
                print("Seeded 10 products successfully.")
            }
        } catch {
            print("Failed to seed products: \(error)")
        }
    }

    // Display first Product
    func displayProduct(_ product: Product) {

        textFields[0].text = product.id ?? ""
        textFields[1].text = product.name ?? ""
        textFields[2].text = product.desc ?? ""
        textFields[3].text = String(format: "%.2f", product.price )
        textFields[4].text = product.provider ?? ""
    }
    
    /// Load The First Product
    func fetchFirstProduct() -> Product? {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        // Sort by ID in ascending order
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first // Return the first product if available
        } catch {
            print("Failed to fetch the first product: \(error)")
            return nil
        }
    }
    
    /// Load All Products
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
      do {
          products = try context.fetch(fetchRequest)
      } catch {
          print("Failed to fetch products: \(error)")
      }
    }
    
    /// NAVIGATE BETWEEN PRODUCTS
    
    @IBAction func showNextProduct(_ sender: UIButton) {
        // If we're at the last product, go back to the first product
        if currentProductIndex < products.count - 1 {
            currentProductIndex += 1
        } else {
            currentProductIndex = 0  // Wrap to the first product
        }
        displayProduct(products[currentProductIndex])
        
    }

    @IBAction func showPreviousProduct(_ sender: UIButton) {
        // If we're at the first product, go to the last product
        if currentProductIndex > 0 {
            currentProductIndex -= 1
        } else {
            currentProductIndex = products.count - 1  // Wrap to the last product
        }
        displayProduct(products[currentProductIndex])
    }


   
    /// BAR ITEM NAVIGATION
    
    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "second_controller") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    
    @IBAction func showProducts(_ sender: UIBarButtonItem) {
        let productsTableVC = storyboard?.instantiateViewController(withIdentifier: "ProductTableViewController") as! ProductTableViewController
        
        
        // Push the new view controller onto the navigation stack
        navigationController?.pushViewController(productsTableVC, animated: true)
    }
    
  
    
}

