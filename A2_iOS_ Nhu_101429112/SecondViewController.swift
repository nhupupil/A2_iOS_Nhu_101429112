//
//  SecondViewController.swift
//  A2_iOS_ Nhu_101429112
//
//  Created by Huynh Yen Nhu Ly on 2025-03-24.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    
    @IBOutlet var textFields: [UITextField]!
    
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

    
    // Fetch Products from Core Data
    func fetchProducts() {
          let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
          
          do {
              products = try context.fetch(fetchRequest)
          } catch {
              print("Failed to fetch products: \(error)")
          }
      }

    @IBAction func submitForm(_ sender: UIButton) {
        let id = textFields[0].text ?? ""
        let name = textFields[1].text ?? ""
        let desc = textFields[2].text ?? ""
        let priceString = textFields[3].text ?? ""
        let provider = textFields[4].text ?? ""
        
        guard let price = Double(priceString) else {
            return
        }
        
        let product = Product(context: context)
        product.id = id
        product.name = name
        price > 0 ? product.price = price : ()
        products.append(product)
    }
}
