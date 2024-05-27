import UIKit

final class DSQuantityPickerUIView: UIView, DSReusableUIView {
    
    
    @IBOutlet weak var pickerView: UIView!
    
    
    @IBOutlet weak var leftView: UIView?
    @IBOutlet weak var rightView: UIView?
    
    
    @IBOutlet weak var leftPickerSpace: NSLayoutConstraint!
    @IBOutlet weak var rightPickerSpace: NSLayoutConstraint!
    
    
    var appearance = DSAppearance.shared.main
    
    @IBOutlet weak var decreaseQuantityButton: ImoUIButton!
    @IBOutlet weak var increaseQuantityButton: ImoUIButton!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    var viewModel: DSQuantityPickerVM?
    
    var addButton: DSButtonVM!
    var removeButton: DSButtonVM!
    
    
    public var view: UIView { self }
    
    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSQuantityPickerVM else { return }
        self.viewModel = viewModel
        
        update(viewModel: viewModel)
        updateLayout(viewModel: viewModel)
        setUpButtonsStyle()
    }
    
    
    
    func updateLayout(viewModel: DSQuantityPickerVM) {
        
        
        rightView?.set(view: viewModel.rightView, designableViewColors: viewModel.viewColors())
        leftView?.set(view: viewModel.leftView, designableViewColors: viewModel.viewColors())
        
        
        leftPickerSpace.constant = (viewModel.leftView == nil) ? 0 : appearance.groupMargins
        rightPickerSpace.constant = (viewModel.rightView == nil) ? 0 : appearance.groupMargins
    }
    
    
    
    func update(viewModel: DSQuantityPickerVM) {        
        quantityLabel.text = viewModel.quantity.string()
        updateQuantityLabel(viewModel: viewModel)
        quantityLabel.setStyle(type: viewModel.quantityTextType, designableTextColor: viewModel.viewColors().text)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setUpButtonsStyle()
    }
    
    func setUpButtonsStyle() {
        
        addButton = DSButtonVM(sfSymbol: "plus")
        removeButton = DSButtonVM(sfSymbol: "minus")
        
        addButton.style.colorStyle = self.viewModel?.style.colorStyle ?? .default
        addButton.style.displayStyle = self.viewModel?.style.displayStyle ?? .default
        decreaseQuantityButton.setUp()
        
        removeButton.style.colorStyle = self.viewModel?.style.colorStyle ?? .default
        removeButton.style.displayStyle = self.viewModel?.style.displayStyle ?? .default
        decreaseQuantityButton.setUp()
        
        increaseQuantityButton.viewModel = addButton
        decreaseQuantityButton.viewModel = removeButton
        
        increaseQuantityButton.button.didTouchUpInside = { _ in
            
            guard let viewModel = self.viewModel else {
                return
            }
            
            viewModel.quantity = viewModel.quantity + 1
            self.updateQuantityLabel(viewModel: viewModel)
            viewModel.quantityDidUpdate?(viewModel.quantity)
            viewModel.quantityDidIncrease?(viewModel.quantity)
        }
        
        decreaseQuantityButton.button.didTouchUpInside = { _ in
            
            guard let viewModel = self.viewModel else {
                return
            }
            
            guard viewModel.quantity >= 1 else {
                return
            }
            
            viewModel.quantity -= 1
            self.updateQuantityLabel(viewModel: viewModel)
            viewModel.quantityDidUpdate?(viewModel.quantity)
            viewModel.quantityDidIncrease?(viewModel.quantity)
        }
    }
    
    func updateQuantityLabel(viewModel: DSQuantityPickerVM) {
        
        var sufix = ""
        
        if let plural = viewModel.quantityPluralText,
           let singular = viewModel.quantitySingularText {
            
            sufix = " \(viewModel.quantity.getCorrectForm(singular: singular, plural: plural))"
        }
        
        self.quantityLabel.text = viewModel.quantity.string() + sufix
    }
    
    class func instanceFromNib() -> DSQuantityPickerUIView {
        let view: DSQuantityPickerUIView = initFromNib()
        return view
    }
}
