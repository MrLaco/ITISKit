import UIKit

public extension DSBaseViewController {

    func loading(_ loading: Bool, delayShowLoading: Bool = true, file: String = #file, line: Int = #line) {
        
        guard let progressHud = self.progressHud else {
            return
        }
        
        var fileName = "No file name"
        if let file = file.components(separatedBy: "/").last {
            fileName = file
        }
        
        progressHud.loading(loading, delayShowLoading: delayShowLoading, file: fileName, line: line)
    }
    
    
    func setUpProgressHud() {
        if let navigationController = self.navigationController {
            for view in navigationController.view.subviews where view.tag == progressHUDTag {
                
                guard let view = view as? ProgressHUD else {
                    return
                }
                progressHud = view
            }

            if progressHud == nil {
                progressHud = ProgressHUD(onView: navigationController.view)
            }
            
        } else {
            progressHud = ProgressHUD(onView: self.view)
        }
    }
}
