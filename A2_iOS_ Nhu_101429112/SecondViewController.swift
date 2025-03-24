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
        let id = idTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let desc = descTextField.text ?? ""
        let priceString = priceTextField.text ?? ""
        let provider = providerTextField.text ?? ""
        
        guard let price = Double(priceString) else {
            return
        }
        
        let product = Product(context: context)
        product.id = id
        product.name = name
        product.desc = desc
        price > 0 ? product.price = price : ()
        product.provider = provider
        
        products.append(product)
        
        saveProduct()
        
        print("submit and save successfully")
    }
    
    func saveProduct() {
        do {
            try context.save()
        } catch {
            print("Error saving new product: \(error)")
        }
    }
}
