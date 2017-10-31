import UIKit
import XCTest
import VendRegisterExtension

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        let testString = "{\"payload\":{\"sale\":{\"totals\":{\"toPay\":\"0\",\"paid\":\"0\",\"price\":\"0\",\"tax\":\"0\"},\"lineItems\":[{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"},{\"unitTax\":\"0\",\"name\":\"winky\",\"quantity\":\"1\",\"taxIdentifier\":\"0a9f6f41-07de-11e5-fbe7-97ba16072568\",\"unitPrice\":\"0\",\"identifier\":\"31eb0866-e7de-11e5-e556-1ea87ccec083\"}],\"identifier\":\"b8e8563c-562e-98e0-11e7-bad08babe802\"},\"retailer\":{\"domainPrefix\":\"samhq\",\"identifier\":\"805e96f6-91bf-11e3-a0f5-b8ca3a64f8f4\"}},\"version\":1}"
        
        let jsonData = testString.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let results = try decoder.decode(Root.self, from: jsonData)
            XCTAssert(results.version == 1)
            XCTAssert(results.payload.sale.totals.toPay == 0)
        } catch {
            XCTFail()
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
