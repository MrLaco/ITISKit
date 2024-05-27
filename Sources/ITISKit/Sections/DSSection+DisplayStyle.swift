import Foundation

extension Array where Element == DSSection {
    
    
    func prepareViewModelsDisplayStyle() {
        
        for section in self {
            
            for (index, model) in section.viewModels.enumerated() {
                
                var model = model
                
                
                
                if section.background.isGrouped {
                    model.style.displayStyle = .grouped(inSection: true)
                }
                
                switch section.background {
                case .grouped:
                    model.style.displayStyle = .grouped(inSection: true)
                
                case .primaryBackground:
                    
                    switch model.style.colorStyle {
                    case .custom(_), .primary, .secondary:
                        break
                    case .default:
                        model.style.colorStyle = .secondary
                    }
                    
                case .secondaryBackground:
                    
                    switch model.style.colorStyle {
                    case .custom(_), .primary, .secondary:
                        break
                    case .default:
                        model.style.colorStyle = .primary
                    }
                case .default:
                    break
                }
                
                
                section.viewModels[index] = model
            }
        }
    }
}
