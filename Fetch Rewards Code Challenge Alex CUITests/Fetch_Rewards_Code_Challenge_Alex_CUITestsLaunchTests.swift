//
//  Fetch_Rewards_Code_Challenge_Alex_CUITestsLaunchTests.swift
//  Fetch Rewards Code Challenge Alex CUITests
//
//  Created by Alex Constancio on 9/27/21.
//

import XCTest

class Fetch_Rewards_Code_Challenge_Alex_CUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
