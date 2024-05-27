import UIKit


struct DSViewModelDataSource: Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model.hash())
    }
    
    static func == (lhs: DSViewModelDataSource, rhs: DSViewModelDataSource) -> Bool {
        lhs.model.isEqual(to: rhs.model)
    }
    
    let model: DSViewModel
}
