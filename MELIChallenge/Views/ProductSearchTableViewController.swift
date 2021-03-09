//
//  ProductSearchTableViewController.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/1/21.
//

import UIKit

class ProductSearchTableViewController: UITableViewController {
    var service: ProductService!
    var searchBarController: UISearchController!
    var searchWorkItem: DispatchWorkItem?
    var isSearchBarEmpty: Bool {
      return searchBarController.searchBar.text?.isEmpty ?? true
    }
    var products: [ProductModel] = []
    var selectedProduct: ProductModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.placeholder = NSLocalizedString("searchBarPlaceholder", comment: "")
        navigationItem.searchController = searchBarController
        definesPresentationContext = true

        searchBarController.searchBar.tintColor = .darkText
        searchBarController.searchBar.searchBarStyle = .prominent
        // Hack to make background white
        searchBarController.searchBar.searchTextField.backgroundColor = .white
        if let textfield = searchBarController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                for view in backgroundview.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.product = products[indexPath.row]
        return cell
    }
}

// MARK: - Navigation

extension ProductSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Flash
        self.selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.product = selectedProduct
    }
}

extension ProductSearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWorkItem?.cancel()
        searchWorkItem = DispatchWorkItem.init { [weak self] in
            guard let self = self else { return }
            self.tableView.isUserInteractionEnabled = true
            if !self.isSearchBarEmpty {
                self.products = []
                self.tableView.reloadData()
                self.tableView.setLoadingView()
                self.service.items(matching: searchText) { [weak self] products in
                    guard let self = self else { return }
                    if self.isSearchBarEmpty { return } // user canceled the search after getting the results
                    guard let products = products else {
                        self.products = []
                        self.tableView.reloadData()
                        self.tableView.removeLoadingView()
                        self.showAlert(NSLocalizedString("connectionErrorText", comment: ""))
                        return
                    }
                    if products.isEmpty {
                        self.showAlert(NSLocalizedString("emptyResults", comment: ""))
                    } else {
                        self.tableView.removeLoadingView()
                    }
                    self.products = products
                    self.tableView.reloadData()
                }
            } else {
                self.products = []
                self.tableView.reloadData()
            }
        }
        tableView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchWorkItem?.cancel()
        searchWorkItem = DispatchWorkItem.init { [weak self] in
            self?.products = []
            self?.tableView.reloadData()
        }
        DispatchQueue.main.async(execute: searchWorkItem!)
    }
    
    func showAlert(_ messageText: String) {
        let alert = UIAlertController(title: NSLocalizedString("errorAlertsTitle", comment: ""), message: messageText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
            self.products = []
            self.tableView.reloadData()
            self.tableView.removeLoadingView()
        }))
        
         self.present(alert, animated: true, completion: nil)
    }
    
}
