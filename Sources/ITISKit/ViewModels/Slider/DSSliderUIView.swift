import UIKit

final class DSSliderUIView: UIView, DSReusableUIView {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    
    private var updateTask: DispatchWorkItem?
    public var view: UIView { self }
    
    var viewModel: DSSliderVM?

    public func setUpWith(viewModel: DSViewModel) {
        
        guard let viewModel = viewModel as? DSSliderVM else { return }
        self.viewModel = viewModel
        update(viewModel: viewModel)
    }

    func update(viewModel: DSSliderVM) {
        
        sliderView.minimumValue = viewModel.minimValue
        sliderView.maximumValue = viewModel.maximValue
        sliderView.value = viewModel.value
        sliderView.minimumTrackTintColor = DSAppearance.shared.main.semanticGreenColor
        labelView.setStyle(type: .subheadline, designableTextColor: viewModel.viewColors().text)
        updateLabel()
    }
    
    @IBAction func didUpdate(_ sender: Any) {
        
        guard let viewModel = viewModel else {
            return
        }
        
        updateLabel()
        
        
        updateTask?.cancel()
        
        updateTask = DispatchWorkItem {
            viewModel.didUpdate?(self.sliderView.value)
        }
        
        guard let updateTask = self.updateTask else {
            return
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: updateTask)
    }
    
    func updateLabel() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        var labelString = ""
        
        if let labelPrefix = viewModel.labelPrefix {
            labelString += "\(labelPrefix)"
        }
        
        labelString += "\(Int(sliderView.value))"
        
        if let labelSuffix = viewModel.labelSuffix {
            labelString += "\(labelSuffix)"
        }
        
        labelView.text = labelString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    class func instanceFromNib() -> DSSliderUIView {
        let view: DSSliderUIView = initFromNib()
        return view
    }
}

