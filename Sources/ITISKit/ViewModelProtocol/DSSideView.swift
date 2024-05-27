import Foundation
import UIKit

public struct DSSideView: Equatable, Hashable {
    
    var viewModel: DSViewModel
    
    public init(view: DSViewModel) {
        self.viewModel = view
    }
    
    public static func == (lhs: DSSideView, rhs: DSSideView) -> Bool {
        return lhs.viewModel.isEqual(to: rhs.viewModel)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(viewModel.hash())
    }
}
