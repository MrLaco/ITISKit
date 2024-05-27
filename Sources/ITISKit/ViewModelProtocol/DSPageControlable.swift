import Foundation

public protocol DSPageControlable {
    var updatePage: ((Int) -> Void)? {get set}
}
