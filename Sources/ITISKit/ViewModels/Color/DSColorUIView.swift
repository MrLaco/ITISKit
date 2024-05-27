import UIKit

final class DSColorUIView: UIView, DSReusableUIView {
    
    @IBOutlet weak var colorView: UIView!

    public var view: UIView { self }

    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSColorVM else { return }
        update(viewModel: viewModel)
    }

    func update(viewModel: DSColorVM) {
        colorView.backgroundColor = viewModel.color
        colorView.layer.cornerRadius = viewModel.viewColors().cornerRadius
        colorView.clipsToBounds = true
        colorView.layer.borderWidth = 1.5
        colorView.layer.borderColor = DSAppearance.shared.main.secondaryView.background.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    class func instanceFromNib() -> DSColorUIView {
        let view: DSColorUIView = initFromNib()
        return view
    }
}

