import UIKit


public struct DSActiveTextVM: DSViewModel, Equatable, Hashable {

    public var text: String
    public var textType: DSTextType
    public var alignment: NSTextAlignment
    public var links = [String: String]()
    public var linksFont: DSTextFont?
    public var height: DSViewModelHeight?

    public init(_ type: DSTextType = .body, text: String, alignment: NSTextAlignment = .natural) {
        self.text = text
        self.alignment = alignment
        self.textType = type
    }

    public var identifier = "ActiveTextView"
    public var accessibilityIdentifier: String = "ActiveTextView"
    public var style: DSViewModelStyle = DSViewModelStyle()
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    
    @NonEquatable public var didTap: ((DSViewModel) -> Void)?
    @NonEquatable public var didTapOnMention: ((String) -> Void)?
    @NonEquatable public var didTapOnHashTag: ((String) -> Void)?
    @NonEquatable public var didTapOnUrl: ((URL) -> Void)?
    @NonEquatable public var didTapOnEmail: ((String) -> Void)?
    @NonEquatable public var didTapOnPhone: ((String) -> Void)?
    @NonEquatable public var object: AnyObject?
    
    public var supplementaryItems: [DSSupplementaryView]?
    public var bottomSideView: DSSideView?
    public var leftSideView: DSSideView?
    public var rightSideView: DSSideView?
    public var topSideView: DSSideView?
}

public extension DSActiveTextVM {

    func height(_ layoutEnvironment: NSCollectionLayoutEnvironment?, section: DSSection) -> DSViewModelHeight {
        return height != nil ? height! : text.estimatedHeight(textType: textType, section: section, layoutEnvironment)
    }

    func viewRepresentation() -> DSReusableUIView {
        return DSActiveTextUIView.instanceFromNib()
    }

    func isEqual(to model: DSViewModel) -> Bool {
        guard let model = model as? Self else { return false }
        return self == model
    }
    
    func hash() -> String {
        return hashValue.string()
    }
}
