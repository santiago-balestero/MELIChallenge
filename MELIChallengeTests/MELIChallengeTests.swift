//
//  MELIChallengeTests.swift
//  MELIChallengeTests
//
//  Created by Santiago Balestero on 2/28/21.
//

import XCTest
@testable import MELIChallenge

class MELIChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchBarPlaceholderText() {
        let viewController = ProductSearchTableViewController()
        var _ = viewController.view
        XCTAssertEqual("Busca en Mercado Libre", viewController.searchBarController.searchBar.placeholder)
    }


    func testProductSearchService() {
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MLU/search?q=Auto") else {
            fatalError("URL can't be empty")
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        let promise = expectation(description: "Call API success")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data, error == nil, let result = response as? HTTPURLResponse else {
                print("Conection error: \(String(describing: error))")
                return
            }
            do {
                XCTAssertTrue(result.statusCode == 200)
                promise.fulfill()
        }

        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testProductsResponseCountService() {
        let productService = ProductService(urlSession: URLSession.shared)
        let promise = expectation(description: "Call API success")
        productService.items(matching: "Auto") {  [weak self] products in
            guard let _ = products else {
                print("Conection error")
                return
            }
            do {
                XCTAssertTrue(products!.count > 0)
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}
