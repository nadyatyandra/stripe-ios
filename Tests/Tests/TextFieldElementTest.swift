//
//  TextFieldElementTest.swift
//  StripeiOS Tests
//
//  Created by Yuki Tokuhiro on 8/23/21.
//  Copyright © 2021 Stripe, Inc. All rights reserved.
//

import XCTest
@testable import Stripe

class TextFieldElementTest: XCTestCase {
    struct Configuration: TextFieldElementConfiguration {
        var defaultValue: String?
        var label: String = "label"
        var maxLength: Int = "default value".count
        
        func updateParams(for text: String, params: IntentConfirmParams) -> IntentConfirmParams? {
            return params
        }
        
        func validate(text: String, isOptional: Bool) -> TextFieldElement.ValidationState {
            return .invalid(TextFieldElement.Error.empty)
        }
    }
    
    func testNoDefaultValue() {
        let element = TextFieldElement(configuration: Configuration(defaultValue: nil))
        XCTAssertTrue(element.textFieldView.text.isEmpty)
        XCTAssertTrue(element.text.isEmpty)
    }
    
    func testDefaultValue() {
        let element = TextFieldElement(configuration: Configuration(defaultValue: "default value"))
        XCTAssertEqual(element.textFieldView.text, "default value")
        XCTAssertEqual(element.text, "default value")
    }
    
    func testInvalidDefaultValueIsSanitized() {
        let element = TextFieldElement(configuration: Configuration(
            defaultValue: "\ndefault\n value that is too long and contains disallowed characters")
        )
        XCTAssertEqual(element.textFieldView.text, "default value")
        XCTAssertEqual(element.text, "default value")
    }
}
