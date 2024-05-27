import UIKit

extension UIPageControl {
    
    func updateAppearance() {
        let appearance = DSAppearance.shared.main
        backgroundColor = appearance.primaryView.background
        pageIndicatorTintColor = appearance.brandColor.lighten(.C500)
        currentPageIndicatorTintColor = appearance.brandColor
    }
}
