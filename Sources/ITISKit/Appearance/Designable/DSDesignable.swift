import UIKit

public protocol DSDesignable {

    var title: String { get set }
    var brandColor: UIColor { get set }
    var primaryView: DSDesignableViewColors { get set }
    var secondaryView: DSDesignableViewColors { get set }
    var statusBarStyleForDarkUserInterfaceStyle: UIStatusBarStyle { get set }
    var statusBarStyleForLightUserInterfaceStyle: UIStatusBarStyle { get set }
    var margins: CGFloat { get set }
    var groupMargins: CGFloat { get set }
    var interItemSpacing: CGFloat { get set }
    var tabBar: DSDesignableTabbarColor { get set }
    var navigationBar: DSDesignableNavigationBarColor { get set }
    var price: DSDesignablePriceColor { get set }
    var fonts: DSDesignableFonts { get set }
    var prefersLargeTitles: Bool { get set }
    var buttonsHeight: CGFloat { get set }
}

extension DSDesignable {
    func statusBarStyle(for style: UIUserInterfaceStyle) -> UIStatusBarStyle {
        
        switch style {
        case .dark:
            return statusBarStyleForDarkUserInterfaceStyle
        case .light:
            return statusBarStyleForLightUserInterfaceStyle
        case .unspecified:
            return statusBarStyleForLightUserInterfaceStyle
        @unknown default:
            return statusBarStyleForLightUserInterfaceStyle
        }
    }
}

public extension DSDesignable {
    var semanticGreenColor: UIColor {
        brandColor.semanticGreenColor
    }
    var semanticRedColor: UIColor {
        brandColor.semanticRedColor
    }
    var semanticYellowColor: UIColor {
        brandColor.semanticYellowColor
    }
    var semanticBlueColor: UIColor {
        brandColor.semanticBlueColor
    }
}

