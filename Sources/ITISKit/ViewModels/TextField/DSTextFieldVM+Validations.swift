import Foundation

public extension DSTextFieldVM {

    func isValid(text: String?, validateEmptyTextField: Bool,_ validate: @escaping (Bool) -> Void) {

        if let userValidation = self.handleValidation {
            validate(userValidation(text))
        } else {
            if text == "" && validateEmptyTextField {
                validate(true)
                
            } else if validator.isValidMinimLength(validateMinimumLength, text) &&
                        validator.isValidMaximLength(validateMaximumLength, text) &&
                        validator.validate(string: text, pattern: validationPattern) &&
                        validator.isValidWhiteSpaces(string: text) {
                
                validate(true)
                
            } else {
                validate(false)
            }
        }
    }
}
