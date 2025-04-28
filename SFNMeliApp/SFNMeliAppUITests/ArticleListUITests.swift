//
//  ArticleListUITests.swift
//  SFNMeliAppUITests
//
//  Created by Alexis Barnique on 26/04/2025.
//

import XCTest

final class ArticleListUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Launch the app before each test
        continueAfterFailure = false
        app.launch()
    }
    
    func testViewListArticleWithItems() throws {
        // Set UITestMode and launch app
        app.launchArguments.append("UITestMode")
        app.launch()
        
        // Validate that list items are displayed
        XCTAssertTrue(app.staticTexts["listItem_30886"].exists)
        XCTAssertTrue(app.staticTexts["listItem_30885"].exists)
        XCTAssertTrue(app.staticTexts["listItem_30884"].exists)
    }
    
    func testSearchBarFiltering() throws {
        // Set UITestMode and launch app
        app.launchArguments.append("UITestMode")
        app.launch()
        
        app.swipeDown()
        
        // Access the search bar
        let searchBar = app.searchFields.firstMatch
        
        XCTAssertTrue(searchBar.exists, "Search bar should exist")
        print(app.debugDescription)
        // Type into the search bar
        searchBar.tap()
        searchBar.typeText("Bio")

        // Verify that filtered items are displayed
        XCTAssertTrue(app.staticTexts["listItem_30886"].exists, "Filtered item '30886' should be displayed")
        XCTAssertFalse(app.staticTexts["listItem_30884"].exists, "Unmatched item '30884' should not be displayed")
        
        // Clear the search text
        searchBar.buttons["Cancel"].tap()
        XCTAssertTrue(app.staticTexts["listItem_30884"].exists, "List should return to its original state")
    }
}
