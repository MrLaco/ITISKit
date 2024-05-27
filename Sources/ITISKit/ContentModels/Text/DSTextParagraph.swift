import UIKit

struct DSTextParagraph: Equatable, Hashable {
    
    let type: DSTextParagraphType
    let newLine: Bool
    let spacing: CGFloat
    let lineSpacing: CGFloat
    let maximumLineHeight: CGFloat
    
    static func == (lhs: DSTextParagraph, rhs: DSTextParagraph) -> Bool {
        return
            lhs.newLine == rhs.newLine &&
            lhs.spacing == rhs.spacing &&
            lhs.type == rhs.type
    }
}
