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
        
        headerViewImage.contentMode = .scaleAspectFill
        headerViewImage.layer.cornerRadius = headerViewImage.frame.size.width / 2
        headerViewImage.clipsToBounds = true
        headerViewImage.layer.borderWidth = 1
        headerViewImage.layer.borderColor = UIColor.white.cgColor

        tableContentObserver = tableView.observe(\UITableView.contentOffset, options: [.old, .new]) { (_, change) in
            guard let newCoordinate = change.newValue, let oldCoordinate = change.oldValue else {
                return
            }
            
            if oldCoordinate.y != newCoordinate.y {
                self.updateHeaderViewHeight(newCoordinate.y)
            }
        }
    }
    
    func updateHeaderViewHeight(_ scrollCoordinate: CGFloat) {
        let newHeaderViewHeight: CGFloat = headerHeightConstraint.constant - scrollCoordinate

        if newHeaderViewHeight >= Constants.maxHeaderHeight {
            self.headerHeightConstraint.constant = min(Constants.maxHeaderHeight, newHeaderViewHeight)
        } else if newHeaderViewHeight < Constants.minHeaderHeight {
            self.headerHeightConstraint.constant = max(Constants.minHeaderHeight, newHeaderViewHeight)
        } else {
            self.headerHeightConstraint.constant = newHeaderViewHeight
        }
        
        self.headerViewImage.layer.cornerRadius = self.headerViewImage.frame.size.width / 2
        
        if newHeaderViewHeight >= Constants.maxHeaderHeight {
                self.headerViewImage.alpha = Constants.maxImageAlpha
        } else if newHeaderViewHeight < Constants.minHeaderHeight + 20 {
                self.headerViewImage.alpha = Constants.minImageAlpha
        } else {
            self.headerViewImage.alpha = newHeaderViewHeight/Constants.maxHeaderHeight
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
