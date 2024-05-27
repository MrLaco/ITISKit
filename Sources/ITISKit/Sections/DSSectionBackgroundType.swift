import Foundation

public enum DSSectionBackgroundType {
    case `default`
    case grouped
    case primaryBackground
    case secondaryBackground
}

extension DSSectionBackgroundType {
    var isGrouped: Bool {
        self == .grouped
    }
}
