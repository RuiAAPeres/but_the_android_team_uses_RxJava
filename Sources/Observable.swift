import ReactiveSwift

public class Observable<Element> {

    fileprivate let producer: SignalProducer<Element, AnyError>

    fileprivate init(producer: SignalProducer<Element, AnyError>) {
        self.producer = producer
    }

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

    public static func create(subscriber: @escaping (Observer<Element>) -> ()) -> Observable<Element> {
        let producer: SignalProducer<Element, AnyError> = SignalProducer { observer, _ in
            subscriber(Observer(observer: observer))
        }

        return Observable(producer: producer)
    }
}

extension Observable {
    @discardableResult
    public func subscribe(_ action: @escaping (Event<Element>) -> Void) -> Disposable {
        let ras_action: (ReactiveSwift.Event<Element, AnyError>) -> Void  = { action($0.to_vanilla_event()) }
        return producer.start(ReactiveSwift.Observer(ras_action))
    }
}
