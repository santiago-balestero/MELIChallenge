//
//  ProductTableViewCell.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/4/21.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    var product: ProductModel! {
        didSet {
            refresh()
        }
    }
    
    private func refresh() {
        titleLabel.text = product.title
        priceLabel.text = "\(product.currency) \(product.price)"
        conditionLabel.text = product.condition.capitalized
        thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        thumbnailImageView.sd_setImage(with: URL(string: product.image), placeholderImage: UIImage(named: "placeholder"))

    }
}
