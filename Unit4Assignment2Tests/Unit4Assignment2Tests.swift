//
//  Unit4Assignment2Tests.swift
//  Unit4Assignment2Tests
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import XCTest
@testable import Unit4Assignment2

class Unit4Assignment2Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    
    func testIfWeatherJSONExists() {
           var data = Data()
           guard let pathToData = Bundle.main.path(forResource: "pixbay", ofType: "json") else { fatalError("Couldn't find json file") }
           let url = URL(fileURLWithPath: pathToData)
           do {
               data = try Data(contentsOf: url)
               XCTAssertTrue(data != nil)
           } catch {
               XCTFail(error.localizedDescription)
       
           }
       }
}
