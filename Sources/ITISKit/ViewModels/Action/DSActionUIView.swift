import UIKit

final class DSActionUIView: UIView, DSReusableUIView {

    @IBOutlet weak var leftViewTopAlignToLabelConstraint: NSLayoutConstraint?
    @IBOutlet weak var leftViewCenterAlignToLabelConstraint: NSLayoutConstraint?
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet var topImageViewEqualHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageViewTopMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageViewRightMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageViewLeftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageViewToLabelSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var leftView: UIView?
    @IBOutlet weak var rightView: UIView?
    @IBOutlet weak var leftLabelSpace: NSLayoutConstraint!
    @IBOutlet weak var rightLabelSpace: NSLayoutConstraint!
    
    
    var appearance = DSAppearance.shared.main
    var viewModel: DSActionVM?

    public var view: UIView { self }

    public func setUpWith(viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSActionVM else { return }
        self.viewModel = viewModel
        update(viewModel: viewModel)
    }

    func update(viewModel: DSActionVM) {
        textLabel.set(text: viewModel.text, designableTextColor: viewModel.viewColors().text)
        updateLayout(viewModel: viewModel)
    }

    func updateLayout(viewModel: DSActionVM) {
        rightView?.set(view: viewModel.rightView, designableViewColors: viewModel.viewColors())
        leftView?.set(view: viewModel.leftView, designableViewColors: viewModel.viewColors())

        leftLabelSpace.constant = (viewModel.leftView == nil) ? 0 : appearance.groupMargins
        rightLabelSpace.constant = (viewModel.rightView == nil) ? 0 : appearance.groupMargins
        
        updateTopImageLayout(viewModel: viewModel)
        updateLeftViewPositions(viewModel: viewModel)
    }

    func updateLeftViewPositions(viewModel: DSActionVM) {
        
        switch viewModel.leftViewPosition {
        case .top:
            leftViewTopAlignToLabelConstraint?.isActive = true
            leftViewCenterAlignToLabelConstraint?.isActive = false
        case .center:
            leftViewTopAlignToLabelConstraint?.isActive = false
            leftViewCenterAlignToLabelConstraint?.isActive = true
        }
    }

    func updateTopImageLayout(viewModel: DSActionVM) {
        topImageView.backgroundColor = viewModel.viewColors().background
        if let topImage = viewModel.topImage {
            setTopImage(image: topImage, viewModel: viewModel)
        } else {
            topImageViewToLabelSpaceConstraint.constant = 0
            topImageViewEqualHeightConstraint.constant = 0
        }
    }

    func setTopImage(image: DSImageContent, viewModel: DSActionVM) {
        topImageView.setImageContent(image)
        
        var cornerRadius: CGFloat = 0
        switch viewModel.style.cornerStyle {
        case .default:
            cornerRadius = viewModel.viewColors().cornerRadius
        case .custom(let radius):
            cornerRadius = radius
        case .zero:
            cornerRadius = 0
        }
        
        topImageView.roundCorner(with: .top, radius: cornerRadius)
        topImageView.setImageContentMode(viewModel.topImageContentMode)

        if let height = viewModel.height, height.isAbsolute {
            topImageViewEqualHeightConstraint.isActive = false
        } else {
            switch viewModel.topImageHeight {
            case .equalTo(let height):
                topImageViewEqualHeightConstraint.isActive = true
                topImageViewEqualHeightConstraint.constant = height
            case .zero:
                topImageViewEqualHeightConstraint.isActive = true
                topImageViewEqualHeightConstraint.constant = 0
            case .unknown:
                topImageViewEqualHeightConstraint.isActive = false
            }
        }

        topImageViewToLabelSpaceConstraint.constant = appearance.interItemSpacing
        
        if viewModel.zeroSpaceToTopImage {
            topImageViewToLabelSpaceConstraint.constant = 0
        }
        
        if viewModel.expandImageOverBoundsForGroups {
            switch viewModel.style.displayStyle {
            case .default:
                defaultTopImageStyle(viewModel: viewModel)
            case .grouped(inSection: _):
                groupedTopImageStyle(viewModel: viewModel)
            }
        } else {
            defaultTopImageStyle(viewModel: viewModel)
        }
    }

    func defaultTopImageStyle(viewModel: DSActionVM) {
        
        topImageViewRightMarginConstraint.constant = 0
        topImageViewTopMarginConstraint.constant = 0
        topImageViewLeftMarginConstraint.constant = 0
        topImageView.layer.cornerRadius = viewModel.viewColors().cornerRadius
    }

    func groupedTopImageStyle(viewModel: DSActionVM) {
        
        topImageViewRightMarginConstraint.constant = -appearance.groupMargins
        topImageViewTopMarginConstraint.constant = -appearance.groupMargins
        topImageViewLeftMarginConstraint.constant = -appearance.groupMargins
        topImageView.layer.cornerRadius = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    class func instanceFromNib() -> DSActionUIView {
        let view: DSActionUIView = initFromNib(bundle: Bundle.main)
        return view
    }
}

