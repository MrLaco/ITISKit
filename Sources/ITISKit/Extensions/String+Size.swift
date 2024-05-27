import Foundation
import UIKit

extension String {

    public func height(forFixedWidth fixedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        return ceil(rect(for: constraintSize, font: font).height)
    }

    public func width(forFixedHeight fixedHeight: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: .greatestFiniteMagnitude, height: fixedHeight)
        return ceil(rect(for: constraintSize, font: font).width)
    }

    private func rect(for constraintSize: CGSize, font: UIFont) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    }

    public func hyphenated() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.hyphenationFactor = 1.0
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byWordWrapping

        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    public func superAndSubscripted(font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self).superAndSubscripted(font: font)
    }

    public func superscripted(font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self).superscripted(font: font)
    }

    public func subscripted(font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self).subscripted(font: font)
    }
}
