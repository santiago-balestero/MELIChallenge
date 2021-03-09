//
//  ProductModel.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/1/21.
//

import Foundation

struct ProductModel {
    
    let title: String
    let price: Float
    let currency: String
    let image: String
    let permalink: String
    let quantity: Int
    let condition: String
    
    init?(json: [String: Any]) {
        guard let name = json["title"] as? String,
              let price = json["price"] as? Float,
              let currency = json["currency_id"] as? String,
              let image = json["thumbnail"] as? String,
              let permalink = json["permalink"] as? String,
              let quantity = json["available_quantity"] as? Int,
              let condition = json["condition"] as? String

        else {
            return nil
        }
        
        self.title = name
        self.price = price
        self.currency = currency
        self.image = "https" + image.dropFirst(4)
        self.permalink = permalink
        self.quantity = quantity
        self.condition = condition
    }
}
