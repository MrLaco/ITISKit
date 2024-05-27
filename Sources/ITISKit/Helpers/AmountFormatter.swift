import Foundation

open class AmountFormatter {

    var amountString: String
    var numberOfDecimals: Int

    static func stringFormatted(amount: Int) -> String {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let finalValue: String? = formatter.string(from: NSNumber(value: amount))
        return finalValue!
    }

    public init() {
        self.amountString = AmountFormatter.stringFormatted(amount: 0)
        self.numberOfDecimals = 2
    }

    public func addDigit(_ digit: Int) {
        let digitString: String = "\(digit)"
        amountString += (digitString)
        shiftDotRight()
    }

    public func removeDigit() {
        let tmpAmount = amountString as NSString
        amountString = tmpAmount.substring(to: tmpAmount.length - 1)
        shiftDotLeft()
    }

    public func shiftDotRight() {

        let tmpAmount = NSMutableString(string: amountString)
        let dotRange: NSRange = (tmpAmount as NSString).range(of: ".")
        tmpAmount.deleteCharacters(in: dotRange)
        tmpAmount.insert(".", at: dotRange.location + 1)

        if tmpAmount.hasPrefix("0") {
            tmpAmount.deleteCharacters(in: NSRange(location: 0, length: 1))
        }

        amountString = tmpAmount as String
    }

    public func shiftDotLeft() {

        let tmpAmount = NSMutableString(string: amountString)
        let dotRange: NSRange = (tmpAmount as NSString).range(of: ".")
        tmpAmount.deleteCharacters(in: dotRange)
        tmpAmount.insert(".", at: dotRange.location - 1)

        if (tmpAmount as NSString).range(of: ".").location == 0 {
            tmpAmount.insert("0", at: 0)
        }

        amountString = tmpAmount as String
    }

    public func formattedAmount() -> String {

        guard let doubleAmount = Double(amountString) else {
            return "0,00"
        }

        let number = NSNumber(value: doubleAmount)
        return number.stringFormatted(withNumberOfDecimals: self.numberOfDecimals)
    }

    public func intAmount() -> Int {
        var tmpAmount = amountString.replacingOccurrences(of: ".", with: "")
        tmpAmount = tmpAmount.replacingOccurrences(of: ",", with: "")
        return tmpAmount.toInt()
    }

    public func amount() -> Int {
        return self.intAmount()
    }
}
