//
//  PrototypeStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Prototype Design Pattern
///
/// Intent: Specify the kinds of objects to create using a prototypical instance,
/// and create new objects by copying this prototype.

class PrototypeStructuralExample: XCTestCase {
    
    /// In Swift, objects can be copied by adopting
    /// NSCopying protocol or providing a custom implementation.
    
    func testPrototype_NSCopying() {
        
        let prototype = SubPrototype()
        prototype.update(intValue: 2, stringValue: "Value2")
        
        guard let anotherPrototype = prototype.copy() as? SubPrototype else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(anotherPrototype == prototype)
        
        /// See implementation of 'Equatable' protocol for more details.
        print("Prototype is equal to the copied object!")
    }
}

/// Coping using NSCopying

class Prototype: NSCopying, Equatable {
    
    private var intValue = 1
    private var stringValue = "Value"
    
    required init() {}
    
    func update(intValue: Int = 1, stringValue: String = "Value") {
        self.intValue = intValue
        self.stringValue = stringValue
    }
    
    /// MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        
        let prototype = type(of: self).init()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        print("Prototype values have been cloned!")
        return prototype
    }
    
    /// MARK: - Equatable
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue
    }
}

class SubPrototype: Prototype {
    
    private var boolValue = true
    
    func copy() -> Any {
        return copy(with: nil)
    }
    
    override func copy(with zone: NSZone?) -> Any {
        guard let prototype = super.copy(with: zone) as? SubPrototype else {
            return SubPrototype() // smth went wrong
        }
        prototype.boolValue = boolValue
        print("SubPrototype values have been cloned!")
        return prototype
    }
}

