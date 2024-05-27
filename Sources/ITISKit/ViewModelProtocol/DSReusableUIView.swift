import UIKit


public protocol DSReusableUIView {

    func setUpWith(viewModel: DSViewModel)

    var view: UIView {get}
}
