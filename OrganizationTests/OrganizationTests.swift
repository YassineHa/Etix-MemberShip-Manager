//
//  OrganizationTests.swift
//  OrganizationTests
//
//  Created by Yassine-Ha on 14/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import XCTest

class OrganizationTests: XCTestCase {
    
    var organization : Organization!
    var organizationViewModel : OrganizationViewModel!
    
    override func setUp() {
        super.setUp()
        organization = Organization(anId: 2, aName: "Tesla")
        organizationViewModel = OrganizationViewModel(anOrganization: organization)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        organization = nil
        organizationViewModel = nil
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
    
    func testSportFasterThanJeep() {
        XCTAssertEqual(organizationViewModel.nameText, "Name: Tesla")
    }
    
   
    
}
