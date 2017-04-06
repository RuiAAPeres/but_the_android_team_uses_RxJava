import ReactiveSwift

public enum Event<Element> {
    case next(Element)
    case error(AnyError)
    case completed
}

extension Event {
    func to_ras_event() -> ReactiveSwift.Event<Element, AnyError> {
        switch self {
        case .completed: return .completed
        case .error(let error): return .failed(error)
        case .next(let element): return .value(element)
        }
    }
}

extension ReactiveSwift.Event {
    func to_vanilla_event() -> Event<Value> {
        switch self {
        case .completed: return .completed
        case .failed(let error): return .error(AnyError(value: error))
        case .value(let value): return .next(value)
        case .interrupted: return .completed
        }
    }
}
