

import UIKit

private let scriptedTextSizeRatio: CGFloat = 0.618

extension NSAttributedString {

    public func height(forFixedWidth fixedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)
        return rect(for: constraintSize, font: font).height
    }

    public func width(forFixedHeight fixedHeight: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: .greatestFiniteMagnitude, height: fixedHeight)
        return rect(for: constraintSize, font: font).width
    }

    private func rect(for constraintSize: CGSize, font: UIFont) -> CGRect {
        let copy = mutableCopy() as! NSMutableAttributedString
        copy.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: length))
        return copy.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, context: nil)
    }

    public func superAndSubscripted(font: UIFont, applyFont: Bool = true) -> NSAttributedString {
        subscripted(font: font).superscripted(font: font, applyFont: false)
    }

    public func superscripted(font: UIFont, applyFont: Bool = true) -> NSAttributedString {
        scripted(
            font: font,
            regex: try! NSRegularExpression(pattern: "\\^\\{([^\\}]*)\\}"), 
            captureBaselineOffset: font.pointSize * (1.0 - scriptedTextSizeRatio),
            applyFont: applyFont
        )
    }

    public func subscripted(font: UIFont, applyFont: Bool = true) -> NSAttributedString {
        scripted(
            font: font,
            regex: try! NSRegularExpression(pattern: "\\_\\{([^\\}]*)\\}"), 
            captureBaselineOffset: font.pointSize * -(scriptedTextSizeRatio / 5),
            applyFont: applyFont
        )
    }

    private func scripted(font: UIFont, regex: NSRegularExpression, captureBaselineOffset: CGFloat, applyFont: Bool = true) -> NSAttributedString {
        
        let unprocessedString = self.mutableCopy() as! NSMutableAttributedString

        if applyFont {
            unprocessedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: unprocessedString.length))
        }

        
        let attributedString = NSMutableAttributedString()

        while let match = regex.firstMatch(
            in: unprocessedString.string,
            options: .reportCompletion,
            range: NSRange(location: 0, length: unprocessedString.length)
        ) {
            
            let substringBeforeMatch = unprocessedString.attributedSubstring(from: NSRange(location: 0, length: match.range.location))
            attributedString.append(substringBeforeMatch)

            
            let capturedSubstring = unprocessedString.attributedSubstring(from: match.range(at: 1)).mutableCopy() as! NSMutableAttributedString
            let captureFullRange = NSRange(location: 0, length: capturedSubstring.length)
            capturedSubstring.addAttribute(.font, value: font.withSize(font.pointSize * scriptedTextSizeRatio), range: captureFullRange)
            capturedSubstring.addAttribute(.baselineOffset, value: captureBaselineOffset, range: captureFullRange)
            attributedString.append(capturedSubstring)

            
            unprocessedString.deleteCharacters(in: NSRange(location: 0, length: match.range.location + match.range.length))
        }

        
        attributedString.append(unprocessedString)

        return attributedString.copy() as! NSAttributedString
    }
}
