import UIKit


public class SystemAppearance: DSDesignable {
    
    
    public var title: String
    
    
    public var brandColor: UIColor
    
    
    public var primaryView: DSDesignableViewColors
    
    
    public var secondaryView: DSDesignableViewColors
    
    
    public var margins: CGFloat = 15
    
    
    public var groupMargins: CGFloat = 10
    
    
    public var interItemSpacing: CGFloat = 7
    
    
    public var tabBar: DSDesignableTabbarColor
    
    
    public var navigationBar: DSDesignableNavigationBarColor
    
    
    public var price: DSDesignablePriceColor
    
    
    public var fonts = DSDesignableFonts()
    
    
    public var prefersLargeTitles: Bool = true
    
    
    public var buttonsHeight: CGFloat = 45
    
    
    public var statusBarStyleForDarkUserInterfaceStyle: UIStatusBarStyle = .lightContent
    public var statusBarStyleForLightUserInterfaceStyle: UIStatusBarStyle = .darkContent
    
    
    
    public init(brandColor: UIColor? = nil, title: String = "System") {
        
        self.title = title
        self.brandColor = brandColor ?? DSColor.color(light: 0x1DA1F2, dark: 0x1DA1F2)
        
        let background = UIColor.systemBackground
        let secondaryBackground = UIColor.secondarySystemBackground
        
        
        
        let button = DSDesignableButtonColor(background: self.brandColor,
                                             title: DSColor.color(light: 0xFEFFFE, dark: 0xFEFFFE))
        
        let text = DSDesignableTextColor(largeTitle: UIColor.label,
                                         title1: UIColor.label,
                                         title2: UIColor.label,
                                         title3: UIColor.label,
                                         headline: UIColor.label,
                                         subheadline: UIColor.secondaryLabel,
                                         body: UIColor.label,
                                         callout: UIColor.secondaryLabel,
                                         caption1: UIColor.secondaryLabel,
                                         caption2: UIColor.tertiaryLabel,
                                         footnote: UIColor.quaternaryLabel)
        
        let secondaryText = DSDesignableTextColor(largeTitle: UIColor.label,
                                                  title1: UIColor.label,
                                                  title2: UIColor.label,
                                                  title3: UIColor.label,
                                                  headline: UIColor.label,
                                                  subheadline: UIColor.secondaryLabel,
                                                  body: UIColor.label,
                                                  callout: UIColor.secondaryLabel,
                                                  caption1: UIColor.secondaryLabel,
                                                  caption2: UIColor.tertiaryLabel,
                                                  footnote: UIColor.quaternaryLabel)
        let separator = UIColor.separator
        
        let primaryViewTextField = DSDesignableTextFieldColor(border: secondaryBackground,
                                                              background: secondaryBackground,
                                                              text: secondaryText.headline,
                                                              placeHolder: secondaryText.subheadline)
        
        primaryView = DSDesignableViewColors(button: button,
                                             text: text,
                                             textField: primaryViewTextField,
                                             background: background,
                                             separator: separator,
                                             cornerRadius: 5)
        
        
        
        let secondaryViewTextField = DSDesignableTextFieldColor(border: background,
                                                                background: background,
                                                                text: text.headline,
                                                                placeHolder: text.subheadline)
        
        secondaryView = DSDesignableViewColors(button: button,
                                               text: secondaryText,
                                               textField: secondaryViewTextField,
                                               background: secondaryBackground,
                                               separator: separator,
                                               cornerRadius: 5)
        
        
        
        tabBar = DSDesignableTabbarColor(barTint: background,
                                         itemTint: button.background,
                                         unselectedItemTint: text.subheadline,
                                         badge: self.brandColor)
        
        
        
        navigationBar = DSDesignableNavigationBarColor(buttons: button.background,
                                                       text: text.title1,
                                                       bar: background)
        
        
        
        price = DSDesignablePriceColor(currency: self.brandColor,
                                       amount: self.brandColor,
                                       regularAmount: text.subheadline)
    }
}
