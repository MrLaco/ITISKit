import UIKit


public protocol DSDesignableViewController {
    var navigationController: UINavigationController? { get }
    var viewController: UIViewController { get }
    var customPresentModalAnimation: UIViewControllerAnimatedTransitioning? { get set }
    var customNavigationControllerAnimation: UIViewControllerAnimatedTransitioning? { get set }
    var customDismissModalAnimation: UIViewControllerAnimatedTransitioning? { get set }
}

public extension DSDesignableViewController {

    func pop() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            print("Cant find an Navigation controller to pop")
        }
    }

    func pop(to: DSDesignableViewController) {
        if let nav = self.viewController.navigationController {
            nav.popToViewController(to.viewController, animated: true)            
        } else {
            print("Cant find an Navigation controller to pop")
        }
    }

    func popToRoot() {
        if let nav = self.viewController.navigationController {
            nav.popToRootViewController(animated: true)
        } else {
            print("Cant find an Navigation controller to pop")
        }
    }

    func push(_ controller: DSDesignableViewController, animated: Bool = true) {
        if let nav = self.navigationController {
            nav.pushViewController(controller.viewController, animated: animated)
        } else {
            print("Cant find an Navigation controller to push")
        }
    }

    func presentInNavigationController(vc: DSDesignableViewController, presentationStyle: UIModalPresentationStyle = .overFullScreen) {
        let navVC = DSNavigationViewController(rootViewController: vc.viewController)
        navVC.modalPresentationStyle = presentationStyle
        self.viewController.present(navVC, animated: true, completion: nil)
    }

    func present(vc: DSDesignableViewController, presentationStyle: UIModalPresentationStyle = .overFullScreen) {
        vc.viewController.modalPresentationStyle = presentationStyle
        self.viewController.present(vc.viewController, animated: true, completion: nil)
    }
    
    func presentVC(vc: UIViewController, presentationStyle: UIModalPresentationStyle = .overFullScreen) {
        vc.modalPresentationStyle = presentationStyle
        self.viewController.present(vc, animated: true, completion: nil)
    }

    func dismissNavigationController() {
        if let nav = viewController.navigationController {
            nav.dismiss(animated: true, completion: nil)
        } else {
            print("Can't find nav vc to dismiss")
        }
    }

    func dismiss() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
