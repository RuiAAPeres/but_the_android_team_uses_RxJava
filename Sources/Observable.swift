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

    public static func create(observer: @escaping (Observer<Element>) -> ()) -> Observable<Element> {
        let producer: SignalProducer<Element, AnyError> = SignalProducer { o, _ in
            observer(Observer(ras_observer: o))
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

extension Observable {
    public func map<U>(_ transform: @escaping (Element) -> U) -> Observable<U> {
        let producer: SignalProducer<U, AnyError> = self.producer.map(transform)
        return Observable<U>(producer: producer)
    }

    public func flatMap<U>(_ transform: @escaping (Element) -> Observable<U>) -> Observable<U> {
        let ras_transform: (Element) -> SignalProducer<U, AnyError> = { element in
            return transform(element).producer
        }
        let producer: SignalProducer<U, AnyError> = self.producer.flatMap(.merge, transform: ras_transform)
        return Observable<U>(producer: producer)
    }
}
