import UIKit

public class MintAppearance: DSDesignable {
    
    
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
    
    
    public var statusBarStyleForDarkUserInterfaceStyle: UIStatusBarStyle = .darkContent
    public var statusBarStyleForLightUserInterfaceStyle: UIStatusBarStyle = .darkContent
    
    
    
    public init(brandColor: UIColor? = nil, title: String = "Mint") {
        
        self.title = title
        self.brandColor = brandColor ?? UIColor(0xFF5A5F)
        
        
        
        let text = DSDesignableTextColor.textColors(main: UIColor(0x484848), secondary: UIColor(0x767676))
        
        let button = DSDesignableButtonColor(background: UIColor(0x00A699), title: UIColor(0xffffff))
        
        let primaryViewTextField = DSDesignableTextFieldColor(border: UIColor(0xF4F4F4),
                                                              background: UIColor(0xF4F4F4),
                                                              text: text.headline,
                                                              placeHolder: text.subheadline)
        
        primaryView = DSDesignableViewColors(button: button,
                                             text: text,
                                             textField: primaryViewTextField,
                                             background: UIColor(0xFFFFFF),
                                             separator: UIColor(0xD5C5B2),
                                             cornerRadius: 8)
        
        
        
        let secondaryText = DSDesignableTextColor.textColors(main: UIColor(0x222222), secondary: UIColor(0x717171))
        
        let secondaryViewTextField = DSDesignableTextFieldColor(border: UIColor(0xFFFFFF),
                                                                background: UIColor(0xFFFFFF),
                                                                text: text.headline,
                                                                placeHolder: text.subheadline)
        
        secondaryView = DSDesignableViewColors(button: button,
                                               text: secondaryText,
                                               textField: secondaryViewTextField,
                                               background: UIColor(0xF4F4F4),
                                               separator: UIColor(0xEBEBEB),
                                               cornerRadius: 8)
        
        
        
        tabBar = DSDesignableTabbarColor(barTint: primaryView.background,
                                         itemTint: primaryView.button.background,
                                         unselectedItemTint: secondaryText.subheadline,
                                         badge: self.brandColor,
                                         translucent: true)
        
        
        
        navigationBar = DSDesignableNavigationBarColor(buttons: primaryView.button.background,
                                                       text: text.title1,
                                                       bar: primaryView.background,
                                                       translucent: true)
        
        
        
        price = DSDesignablePriceColor(currency: UIColor(0xFC642D),
                                       amount: UIColor(0xFC642D),
                                       regularAmount: UIColor(0x672912),
                                       badgeBackground: UIColor(0xFF5A5F))
    }
}
