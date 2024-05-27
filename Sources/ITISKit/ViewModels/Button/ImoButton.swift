import UIKit

open class ImoButton: UIButton {

    public var didTouchUpInside: ((Any?) -> Void)?
    
    public init() {
        
        super.init(frame: CGRect.zero)
        self.addTarget(self, action: #selector(touchUpInside),
                       for: UIControl.Event.touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside),
                       for: UIControl.Event.touchUpInside)
    }
    
    public var title: String? {

        get { return self.currentTitle }
        set {
            setTitle(newValue, for: .normal)
            setTitle(newValue, for: .disabled)
        }
    }
    
    public var titleColor: UIColor? {
        get { return currentTitleColor }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    public var disabledTitleColor: UIColor? {
        get { return titleColor(for: .disabled) }
        set { setTitleColor(newValue, for: .disabled) }
    }
    
    @objc func touchUpInside() {
        if let didTouchUpInside = self.didTouchUpInside {
            didTouchUpInside(nil)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -30, dy: -30).contains(point)
    }
}
