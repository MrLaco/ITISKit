import Foundation

public extension DSTextFieldVM {

    static func email(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternEmail
        model.validateMinimumLength = 5
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "envelope"
        model.keyboardType = .emailAddress
        model.textContentType = .emailAddress
        return model
    }

    static func phone(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternPhoneNumber
        model.validateMinimumLength = 5
        model.validateMaximumLength = 35
        model.leftSFSymbolName = "phone"
        model.keyboardType = .phonePad
        model.textContentType = .telephoneNumber
        return model
    }

    static func secureCode(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternLettersAndNumbers
        model.validateMinimumLength = 4
        model.validateMaximumLength = 10
        model.leftSFSymbolName = "lock"
        model.keyboardType = .phonePad
        model.isSecured = true
        return model
    }

    static func password(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.isSecured = true
        model.validateMinimumLength = 8
        model.validateMaximumLength = 14
        model.keyboardType = .default
        model.leftSFSymbolName = "lock"
        model.textContentType = .password
        return model
    }

    static func newPassword(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.isSecured = true
        model.validateMinimumLength = 8
        model.validateMaximumLength = 14
        model.keyboardType = .default
        model.leftSFSymbolName = "lock"
        model.textContentType = .newPassword
        return model
    }

    static func name(text: String? = nil, placeholder: String, identifier: String? = nil) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternName
        model.validateMinimumLength = 3
        model.validateMaximumLength = 35
        model.leftSFSymbolName = "person.crop.circle"
        model.keyboardType = .default
        model.textContentType = .name
        model.autocapitalizationType = .words
        
        return model
    }

    static func givenName(text: String? = nil, placeholder: String, identifier: String? = nil) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternName
        model.validateMinimumLength = 3
        model.validateMaximumLength = 35
        model.leftSFSymbolName = "person.crop.circle"
        model.keyboardType = .default
        model.textContentType = .givenName
        model.autocapitalizationType = .words
        
        return model
    }

    static func familyName(text: String? = nil, placeholder: String, identifier: String? = nil) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternName
        model.validateMinimumLength = 3
        model.validateMaximumLength = 35
        model.leftSFSymbolName = "person.crop.circle"
        model.keyboardType = .default
        model.textContentType = .familyName
        model.autocapitalizationType = .words
        
        return model
    }

    static func number(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternNumbers
        model.validateMinimumLength = 3
        model.validateMaximumLength = 35
        model.leftSFSymbolName = "number.circle"
        model.keyboardType = .numberPad
        model.textContentType = .username
        
        return model
    }

    static func address(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .fullStreetAddress
        model.autocapitalizationType = .words
        
        return model
    }

    static func search(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validateMinimumLength = 0
        model.validateMaximumLength = 200
        model.leftSFSymbolName = "magnifyingglass"
        model.keyboardType = .default
        model.autocapitalizationType = .sentences
        
        return model
    }

    static func streetAddressLine1(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .streetAddressLine1
        model.autocapitalizationType = .words
        
        return model
    }

    static func streetAddressLine2(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .streetAddressLine2
        model.autocapitalizationType = .words
        
        return model
    }

    static func addressState(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .addressState
        model.autocapitalizationType = .words
        
        return model
    }

    static func addressCity(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .addressCity
        model.autocapitalizationType = .words
        
        return model
    }

    static func addressCityAndState(text: String? = nil, placeholder: String) -> DSTextFieldVM {
        
        let model = DSTextFieldVM(text: text, placeholder: placeholder)
        model.validationPattern = patternAddress
        model.validateMinimumLength = 3
        model.validateMaximumLength = 250
        model.leftSFSymbolName = "house"
        model.keyboardType = .default
        model.textContentType = .addressCityAndState
        model.autocapitalizationType = .words

        return model
    }
}
