import UIKit

final class DSSwitchUIView: UIView, DSReusableUIView {
    
    @IBOutlet weak var switchView: UISwitch!
    
    public var view: UIView { self }
    
    var viewModel: DSSwitchVM?

    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSSwitchVM else { return }
        self.viewModel = viewModel
        update(viewModel: viewModel)
    }
    
    func update(viewModel: DSSwitchVM) {
        switchView.isOn = viewModel.isOn
        switchView.onTintColor = DSAppearance.shared.main.semanticGreenColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    @IBAction func didUpdate(_ sender: Any) {
        
        guard let viewModel = self.viewModel else {
           return
        }
        
        viewModel.didUpdate?(self.switchView.isOn)
    }
    
    class func instanceFromNib() -> DSSwitchUIView {
        let view: DSSwitchUIView = initFromNib()
        return view
    }
}

