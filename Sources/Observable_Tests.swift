import XCTest
import ReactiveSwift
@testable import but_the_android_team_uses_RxJava

final class Observable_Tests: XCTestCase {

    func test_Observable_just() {

        let expect = expectation(description: "")
        let observable = Observable<Int>.just(value: 1)

        var count = 0
        let action: (but_the_android_team_uses_RxJava.Event<Int>) -> Void = { event in
            switch count {
            case 0: XCTAssertEqual(event.to_ras_event().value, 1)
            case 1: expect.fulfill()
            default: fatalError("Not Expected")
            }
            count += 1
        }

        observable.subscribe(action)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
