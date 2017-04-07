import ReactiveSwift

public struct Observer<Element> {
    private let observer: ReactiveSwift.Observer<Element, AnyError>

    init(ras_observer: ReactiveSwift.Observer<Element, AnyError>) {
        self.observer = ras_observer
    }

    public init(action: @escaping (Event<Element>) -> Void) {
        let ras_action: (ReactiveSwift.Event<Element, AnyError>) -> Void  = { action($0.to_vanilla_event()) }
        self.observer = ReactiveSwift.Observer(ras_action)
    }

    public func onNext(_ value: Element) {
        observer.send(value: value)
    }

    public func onError(_ error: Error) {
        observer.send(error: AnyError(value: error))
    }

    public func onCompleted() {
        observer.sendCompleted()
    }
}
