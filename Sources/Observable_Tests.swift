import XCTest
import ReactiveSwift
@testable import but_the_android_team_uses_RxJava

final class Observable_Tests: XCTestCase {

    func test_just() {

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

    func test_from() {
        let expect = expectation(description: "")
        let observable = Observable<Int>.from(values: 1, 2)

        var count = 0
        let action: (but_the_android_team_uses_RxJava.Event<Int>) -> Void = { event in
            switch count {
            case 0: XCTAssertEqual(event.to_ras_event().value, 1)
            case 1: XCTAssertEqual(event.to_ras_event().value, 2)
            case 2: expect.fulfill()
            default: fatalError("Not Expected")
            }
            count += 1
        }

        observable.subscribe(action)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func test_create() {
        let expect = expectation(description: "")
        let observable = Observable<Int>.create { o in
            o.onNext(1)
            o.onCompleted()
        }
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
