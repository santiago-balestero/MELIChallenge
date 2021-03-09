//
//  UITableViewExtensions.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/8/21.
//

import UIKit

extension UITableView {
    
    func setLoadingView() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = self.frame
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.separatorStyle = .none
        self.backgroundView = spinner
    }
    
    func removeLoadingView() {
        self.backgroundView = UIView()
        self.separatorStyle = .singleLine
    }
    
    func setupBackgroundView() {
        let messageLabel = UILabel(frame: self.bounds)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = messageLabel
    }
}
