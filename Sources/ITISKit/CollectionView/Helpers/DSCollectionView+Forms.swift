import Foundation

extension DSCollectionView {
    
    func isCurrentFormValid(_ validate: @escaping (Bool) -> Void) {

        guard !self.adaptedContent.isEmpty else {
            validate(true)
            return
        }
        
        var verifiedViewModels: Int = 0
        
        var isValid = true
        
        for section in adaptedContent {
            
            for model in section.viewModels {
                
                guard let model = model as? DSTextFieldVM else {
                    continue
                }
                
                
                model.validateTextField?()
                
                model.isValid(text: model.text, validateEmptyTextField: false, { isViewTextFieldValid in
                    
                    verifiedViewModels += 1
                    
                    if !isViewTextFieldValid {
                        isValid = false
                    }
                    
                    if verifiedViewModels == self.adaptedContent.totalTextFieldViewModelsCount {
                        validate(isValid)
                    }
                })
            }
        }
    }
}
