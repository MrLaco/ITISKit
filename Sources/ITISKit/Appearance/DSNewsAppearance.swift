import UIKit

public class DSNewsAppearance: DSDesignable {
    
    
    public var title: String
    
    
    public var brandColor: UIColor
    
    
    public var primaryView: DSDesignableViewColors
    
    
    public var secondaryView: DSDesignableViewColors
    
    
    public var margins: CGFloat = 15
    
    
    public var groupMargins: CGFloat = 10

    
    public var interItemSpacing: CGFloat = 10
    
    
    public var tabBar: DSDesignableTabbarColor
    
    
    public var navigationBar: DSDesignableNavigationBarColor
    
    
    public var textField: DSDesignableTextFieldColor
    
    
    public var price: DSDesignablePriceColor
    
    
    public var fonts = DSDesignableFonts()
    
    
    public var prefersLargeTitles: Bool = true
    
    
    public var buttonStyle: ImoUIButtonStyle = .default
    
    
    public var buttonsHeight: CGFloat = 48
    
    
    public var statusBarStyleForDarkUserInterfaceStyle: UIStatusBarStyle = .lightContent
    public var statusBarStyleForLightUserInterfaceStyle: UIStatusBarStyle = .darkContent
    
    
    
    public init(brandColor: UIColor? = nil) {
        
        self.title = "News"
        self.brandColor = brandColor ?? DSColor.color(light: 0x1DA1F2, dark: 0x1DA1F2)
        
        
        
        
        let text = DSDesignableTextColor(largeTitle: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         title1: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         title2: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         title3: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         headline: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         subheadline: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                         body: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                         callout: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                         caption1: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                         caption2: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                         footnote: DSColor.color(light: 0x5b7083, dark: 0x8899a6))
        
        
        let primaryViewTextField = DSDesignableTextFieldColor(border: DSColor.color(light: 0xf3f4f2, dark: 0x101a24),
                                                              background: DSColor.color(light: 0xf3f4f2, dark: 0x101a24),
                                                              text: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                              placeHolder: DSColor.color(light: 0x5b7083, dark: 0x8899a6))
        
        
        let button = DSDesignableButtonColor(background: DSColor.color(light: 0x1da1f2, dark: 0x1da1f2),
                                             title: DSColor.color(light: 0xfefffe, dark: 0xfefffe))
        
        
        let background = DSColor.color(light: 0xfefffe, dark: 0x15202b)
        
        
        let separator = DSColor.color(light: 0xd0dbe3, dark: 0x38444d)
        
        
        let cornerRadius: CGFloat = 10
        
        
        primaryView = DSDesignableViewColors(button: button,
                                             text: text,
                                             textField: primaryViewTextField,
                                             background: background,
                                             separator: separator,
                                             cornerRadius: cornerRadius)
        
        
        
        
        let secondaryText = DSDesignableTextColor(largeTitle: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  title1: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  title2: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  title3: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  headline: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  subheadline: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                                  body: DSColor.color(light: 0x14171a, dark: 0xfefffe),
                                                  callout: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                                  caption1: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                                  caption2: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                                  footnote: DSColor.color(light: 0x5b7083, dark: 0x8899a6))
        
        
        let secondaryViewTextField = DSDesignableTextFieldColor(border: DSColor.color(light: 0xfefffe, dark: 0x15202b),
                                                                background: DSColor.color(light: 0xfefffe, dark: 0x15202b),
                                                                text: text.headline,
                                                                placeHolder: text.subheadline)
        
        
        let sButton = DSDesignableButtonColor(background: DSColor.color(light: 0x5b7083, dark: 0x8899a6),
                                              title: DSColor.color(light: 0xfefffe, dark: 0xfefffe))
        
        
        let sBackground = DSColor.color(light: 0xf3f4f2, dark: 0x101a24)
        
        
        let sSeparator = DSColor.color(light: 0xd0dbe3, dark: 0x38444d)
        
        
        let sCornerRadius: CGFloat = 10
        
        
        secondaryView = DSDesignableViewColors(button: sButton,
                                               text: secondaryText,
                                               textField: secondaryViewTextField,
                                               background: sBackground,
                                               separator: sSeparator,
                                               cornerRadius: sCornerRadius)
        
        
        
        tabBar = DSDesignableTabbarColor(barTint: primaryView.background,
                                         itemTint: primaryView.button.background,
                                         unselectedItemTint: text.subheadline,
                                         badge: self.brandColor,
                                         translucent: false)
        
        
        
        navigationBar = DSDesignableNavigationBarColor(buttons: primaryView.button.background,
                                                       text: text.title1,
                                                       bar: primaryView.background,
                                                       translucent: false)
        
        
        
        textField = DSDesignableTextFieldColor(border: primaryView.separator,
                                               background: secondaryView.background,
                                               text: secondaryView.text.title1,
                                               placeHolder: secondaryView.text.subheadline)
        
        
        
        price = DSDesignablePriceColor(currency: text.headline,
                                       amount: text.headline,
                                       regularAmount: text.subheadline,
                                       badgeBackground: UIColor(0xFF656B))
    }
}
