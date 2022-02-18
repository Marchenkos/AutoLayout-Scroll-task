import UIKit

class ViewController: UIViewController {
    let products = Product.getData()
    var tableContentObserver: NSKeyValueObservation?

    @IBOutlet var headerViewImage: UIImageView!
    @IBOutlet var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    private enum Constants {
        static let estimatedRowHeight: CGFloat = 600
        static let cellIdentifier = "ProductCell"
        static let maxHeaderHeight: CGFloat = 160
        static let minHeaderHeight: CGFloat = 60
        static let minImageAlpha: CGFloat = 0
        static let maxImageAlpha: CGFloat = 1
        static let animationDuration: Double = 0.5
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        tableContentObserver = tableView.observe(\UITableView.contentOffset, options: .new) { (_, change) in
            guard let newCoordinate = change.newValue else {
                return
            }

            self.updateHeaderViewHeight(newCoordinate.y)
        }
    }
    
    func updateHeaderViewHeight(_ scrollCoordinate: CGFloat) {
        let newHeaderViewHeight: CGFloat = headerHeightConstraint.constant - scrollCoordinate
        
        UIView.animate(withDuration: Constants.animationDuration) {
            if newHeaderViewHeight > Constants.maxHeaderHeight {
                self.headerHeightConstraint.constant = min(Constants.maxHeaderHeight, newHeaderViewHeight)
                self.headerViewImage.alpha = Constants.maxImageAlpha
            } else if newHeaderViewHeight < Constants.minHeaderHeight {
                self.headerHeightConstraint.constant = Constants.minHeaderHeight
                self.headerViewImage.alpha = Constants.minImageAlpha

            } else {
                self.headerHeightConstraint.constant = newHeaderViewHeight
            }
    
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ProductCell
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
