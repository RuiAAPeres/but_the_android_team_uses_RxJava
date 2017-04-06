public struct AnyError: Error {
    let value: Error

    init(value: Error) {
        self.value = value
    }
}
