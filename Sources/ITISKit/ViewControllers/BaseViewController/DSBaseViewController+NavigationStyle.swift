import UIKit

public extension DSBaseViewController {
    
    var prefersLargeTitles: Bool? {
        
        set {
            navigationController?.navigationBar.prefersLargeTitles = newValue ?? false
        }
        get {
            return navigationController?.navigationBar.prefersLargeTitles
        }
    }

    func setUpLargeTitleDisplayMode() {
        
        navigationItem.largeTitleDisplayMode = (self.navigationController?.viewControllers.first == self ? .always : .never)        
        navigationController?.navigationBar.prefersLargeTitles = DSAppearance.shared.main.prefersLargeTitles
        definesPresentationContext = true
        
        if let nav = self.navigationController {
            nav.definesPresentationContext = true
        }
        
        if let tabbar = self.tabBarController {
            tabbar.definesPresentationContext = true
        }
    }

    func hideNavigationBarShadow() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    func showNavigationBarShadow() {
         
        let navColor = DSAppearance.shared.main.navigationBar
        
        var shadowImage = UIImage(color: UIColor.colorOverlay(mainColor: navColor.bar,
                                                              overlayColor: navColor.text,
                                                              opacity: 0.5)!)
        
        shadowImage = shadowImage?.resizeImage(size: CGSize(width: 1, height: 0.5))
        
        self.navigationController?.navigationBar.shadowImage = shadowImage
    }

    func hideNavigationBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
