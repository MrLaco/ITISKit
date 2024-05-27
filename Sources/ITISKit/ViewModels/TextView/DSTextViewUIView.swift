import UIKit

final class DSTextViewUIView: UIView, DSReusableUIView, UITextViewDelegate {
    
    @IBOutlet weak var textViewHolder: UITextView!
    @IBOutlet weak var textView: UITextView!
    var viewModel: DSTextViewVM?

    public var view: UIView { self }

    public func setUpWith(viewModel: DSViewModel) {
        guard let viewModel = viewModel as? DSTextViewVM else { return }
        self.viewModel = viewModel
        update(viewModel: viewModel)
    }

    func update(viewModel: DSTextViewVM) {
        
        let colors = viewModel.viewColors(mirrored: true)        
        textView.textColor = colors.text.body
        textView.font = DSAppearance.shared.main.fonts.body
        textView.text = viewModel.text
        
        backgroundColor = colors.background
        layer.cornerRadius = colors.cornerRadius
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.viewModel?.text = textView.text
        
        guard let vm = self.viewModel else {
            return
        }
        
        self.viewModel?.didUpdate?(vm)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> DSTextViewUIView {
        let view: DSTextViewUIView = initFromNib()
        return view
    }
}
