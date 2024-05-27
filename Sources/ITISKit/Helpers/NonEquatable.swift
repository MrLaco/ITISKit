import Foundation

@propertyWrapper
public struct NonEquatable<Value>: Equatable, Hashable {
    public var wrappedValue: Value
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public static func == (lhs: NonEquatable<Value>, rhs: NonEquatable<Value>) -> Bool {
        true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine("NonHashable")
    }
}
