import XCTest
@testable import Advance


class ObservableTests : XCTestCase {
    
    func testEvent() {
        let payload = 123
        
        let sink = Sink<Int>()
        
        let observable = sink.observable
        
        var output: Int? = nil
        
        observable.observe { (value) -> Void in
            output = payload
        }
        
        sink.send(value: payload)
        
        XCTAssertEqual(output, payload)
        
    }
    
    func testRemoveObserver() {
        
        let payload = 123
        let sink = Sink<Int>()
        let observable = sink.observable
        
        var output: Int? = nil
        
        let subscription = observable.observe { (value) -> Void in
            output = value
        }
        
        sink.send(value: payload)
        XCTAssertEqual(payload, output)
        
        output = nil
        subscription.unsubscribe()
        sink.send(value: payload)
        XCTAssertNil(output)
    }
}