import Foundation

extension String {
    var currencySymbol: String {
        switch self {
        case "EUR": return "€"
        case "USD": return "$"
        case "GBP": return "£"
        default: return self
        }
    }
}
