//
//  ViewController.swift
//  A2_iOS_ Nhu_101429112
//
//  Created by Huynh Yen Nhu Ly on 2025-03-24.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "second_controller") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    
    @IBAction func showProducts(_ sender: UIBarButtonItem) {
    }
    
}

