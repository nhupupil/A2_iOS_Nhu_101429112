//
//  TableTableViewController.swift
//  A2_iOS_ Nhu_101429112
//
//  Created by Huynh Yen Nhu Ly on 2025-03-24.
//

import UIKit
import CoreData

class ProductTableViewController: UITableViewController,UISearchBarDelegate {
    
    var filteredProducts: [Product] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Title
        self.title = "Product List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        /// Setup the search bar
        searchBar.delegate = self

        /// Fetch products from CoreData
        if products.isEmpty {
            fetchProducts()
        }
        /// Set the initial filtered products to all products
        filteredProducts = products
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
        
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            products = try context.fetch(fetchRequest)
            filteredProducts = products  // Initially show all products

            tableView.reloadData()  // Reload the table data after fetching
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }

    // Search function to filter products based on name or description
    func filterProducts(for query: String) {
        if query.isEmpty {
            filteredProducts = products  // If search query is empty, show all products
        } else {
            filteredProducts = products.filter { product in
                let nameMatches = product.name?.lowercased().contains(query.lowercased()) ?? false
                let descMatches = product.desc?.lowercased().contains(query.lowercased()) ?? false
                return nameMatches || descMatches
            }
        }
        tableView.reloadData()  // Update table view with filtered products
    }
    
    // MARK: - Search Bar Delegate Methods
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Call the filter method whenever the search bar text changes
            filterProducts(for: searchText)
        }
        
        // Dismiss keyboard when the search button is clicked
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()  // Dismiss the keyboard
        }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)

        // Configure the cell...
        let product = filteredProducts[indexPath.row]

        cell.textLabel?.text = product.name ?? "no name"
        cell.detailTextLabel?.text = product.desc ?? "no description"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
