//
//  DetailViewController.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/5/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var product: ProductModel! {
        didSet {
            refresh()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func refresh() {
        loadViewIfNeeded()
        titleLabel.text = product.title
        priceLabel.text = "\(product.currency) \(product.price)"
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        imageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func onViewOnWebButtonTouchUpInside(_ sender: Any) {
        if let link = URL(string: product.permalink) {
          UIApplication.shared.open(link)
        }
    }
    
}
