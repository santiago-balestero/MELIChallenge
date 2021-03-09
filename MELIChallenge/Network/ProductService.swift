//
//  ProductService.swift
//  MELIChallenge
//
//  Created by Santiago Balestero on 3/2/21.
//

import Foundation

class ProductService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func items(matching query: String, completion: @escaping ([ProductModel]?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = NSLocalizedString("baseUrl", comment: "")
        urlComponents.path = NSLocalizedString("productSearchEndpoint", comment: "")
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        urlSession.dataTask(with: urlComponents.url!, completionHandler: { (data, response, error) in
            var items: [ProductModel] = []

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
  
            if let results = json["results"] as? [Any] {
                for result in results {
                    if let item = ProductModel(json: result as! [String : Any]) {
                        items.append(item)
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(items)
            }
        }).resume()
    }
}
