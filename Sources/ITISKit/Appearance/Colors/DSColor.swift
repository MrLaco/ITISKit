import UIKit

public class DSColor {

    public static func color(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }

    public static func color(light: Int, dark: Int) -> UIColor {
        return color(light: UIColor(light), dark: UIColor(dark))
    }
}
