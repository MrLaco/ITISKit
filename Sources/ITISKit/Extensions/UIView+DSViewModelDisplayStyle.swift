import UIKit

extension UIView {
    
    func setReusableViewStyle(model: DSViewModel) {

        var cornerRadius: CGFloat = 0
        switch model.style.cornerStyle {
        case .default:
            cornerRadius = model.viewColors().cornerRadius
        case .custom(let radius):
            cornerRadius = radius
        case .zero:
            cornerRadius = 0
        }

        switch model.style.displayStyle {
        case .default:
            clipsToBounds = false
            backgroundColor = .clear
            layer.cornerRadius = cornerRadius
        case .grouped(inSection: let inSection):
            
            if inSection {
                clipsToBounds = false
                backgroundColor = .clear
                layer.cornerRadius = 0
            } else {
                clipsToBounds = true
                backgroundColor = model.viewColors().background
                layer.cornerRadius = cornerRadius
            }
        }

        configureBorder(model.style.borderStyle, viewColors: model.viewColors())
        
        switch model.style.shadowStyle {
        case .none:
            layer.shadowColor = nil
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
            layer.shadowOffset = .zero
        case .small:
            clipsToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 1
            layer.shadowOpacity = 0.1
            layer.shadowOffset = .init(width: 0, height: 1)
        case .light:
            clipsToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 4
            layer.shadowOpacity = 0.05
            layer.shadowOffset = .init(width: 0, height: 0)
        }
    }
}
