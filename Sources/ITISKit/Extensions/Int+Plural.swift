import Foundation

public extension Int {

    func getCorrectForm(singular: String, plural: String) -> String {
        if self == 1 {
            return singular
        } else if self > 1 {
            return plural
        } else {
            return plural
        }
    }
}
