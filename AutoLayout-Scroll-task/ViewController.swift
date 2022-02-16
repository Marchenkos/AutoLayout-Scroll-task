//
//  ViewController.swift
//  AutoLayout-Scroll-task
//
//  Created by Kseniya on 14.02.22.
//

import UIKit

class ViewController: UIViewController {
    let products = Products.getData()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let productItem = products[indexPath.row]
        cell.productName.text = productItem.name
        cell.productDescription.text = productItem.description
        cell.productPrice.text = "$\(productItem.price)"
        cell.productImage.image = UIImage(named: productItem.image)
        
        cell.productName.adjustsFontSizeToFitWidth = false
        cell.productName.lineBreakMode = .byTruncatingTail
    
        cell.productPrice.adjustsFontSizeToFitWidth = true
        cell.productPrice.lineBreakMode = .byTruncatingTail
        
        return cell
    }
}

