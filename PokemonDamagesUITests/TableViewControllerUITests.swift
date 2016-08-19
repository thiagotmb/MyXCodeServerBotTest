//
//  TableViewControllerUITests.swift
//  PokemonDamages
//
//  Created by Thiago-Bernardes on 8/17/16.
//  Copyright © 2016 TMB. All rights reserved.
//

import XCTest

class TableViewControllerUITests: XCTestCase {
    
    let app = XCUIApplication()
    var tablesQuery: XCUIElementQuery!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
        
        self.tablesQuery = app.tables
    }
    
    func testNumberOfCells() {
        self.waitTableViewLoad()
        XCTAssertEqual(self.tablesQuery.cells.count, 20)
    }
    
    func testContentOfCells() {
        self.waitTableViewLoad()
        let lastLabel = self.tablesQuery.cells.elementBoundByIndex(19).staticTexts.elementBoundByIndex(0)
        let middleLabel = self.tablesQuery.cells.elementBoundByIndex(10).staticTexts.elementBoundByIndex(0)
        let firstLabel = self.tablesQuery.cells.elementBoundByIndex(0).staticTexts.elementBoundByIndex(0)
        
        XCTAssertGreaterThanOrEqual(lastLabel.label, middleLabel.label)
        XCTAssertGreaterThanOrEqual(middleLabel.label, firstLabel.label)
        XCTAssertEqual(firstLabel.label, "bug")
        
    }
    
    func waitTableViewLoad() {
        let firePokemonCell = self.tablesQuery.cells.staticTexts["fire"]
        let firePokemonCellExistsOnView = NSPredicate(format: "exists == 1")
        expectationForPredicate(firePokemonCellExistsOnView,
                                evaluatedWithObject: firePokemonCell,
                                handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        
    }
    
    func testCellSelection() {
        self.waitTableViewLoad()
        let firstCell =  self.app.tables.staticTexts["bug"]
        firstCell.tap()
        
        XCTAssertTrue(!firstCell.selected)
    }
}
