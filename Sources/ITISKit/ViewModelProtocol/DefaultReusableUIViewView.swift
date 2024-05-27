import UIKit

public class DefaultReusableUIViewView: UIView, DSReusableUIView {
    
    public var view: UIView {
        self
    }
    
    public func setUpWith(viewModel: DSViewModel) {
        print("Please implement getUIViewRepresentation() protocol method for \(viewModel)")
    }
}
