import UIKit

final class DSButtonUIView: UIView, DSReusableUIView {
    
    @IBOutlet weak var button: ImoUIButton!
    
    var viewModel: DSButtonVM?
    
    public var view: UIView { self }
    
    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSButtonVM else {
            return
        }
        
        self.viewModel = viewModel
        update(viewModel: viewModel)
    }
    
    func update(viewModel: DSButtonVM) {
        
        button.setUpWith(viewModel: viewModel)
        
        
        button.button.didTouchUpInside = { [weak self] _ in
            
            guard let _self = self else {
                return
            }
            
            _self.viewModel?.didTap?(viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        button.backgroundColor = .clear
    }
    
    class func instanceFromNib() -> DSButtonUIView {
        let view: DSButtonUIView = initFromNib()
        return view
    }
}

