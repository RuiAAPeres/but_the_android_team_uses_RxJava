import ReactiveSwift

public class Observable<Element> {

    private let producer: SignalProducer<Element, AnyError>

    public init(values: [Element]) {
        self.producer = SignalProducer(values)
    }

    public init(value: Element) {
        self.producer = SignalProducer(value: value)
    }
}

extension Observable {
    public static func from(values: Element...) -> Observable<Element> {
        return Observable(values: values)
    }

    public static func just(value: Element) -> Observable<Element> {
        return Observable(value: value)
    }
}
