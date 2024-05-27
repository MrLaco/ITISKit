import Foundation

public extension Array where Element == DSViewModel {

    func didTap<T: DSViewModel>(_ tap: @escaping ((T) -> Void)) -> [DSViewModel] {
        
        let array = self.map { (viewModel) -> DSViewModel in
            
            var viewModel = viewModel
            
            viewModel.didTap = { model in
                guard let model = model as? T else { return }
                tap(model)
            }
            
            return viewModel
        }
        
        return array
    }

    func didTap(_ tap: @escaping ((DSViewModel) -> Void)) -> [DSViewModel] {
        
        let array = self.map { (viewModel) -> DSViewModel in
            
            var viewModel = viewModel
            
            viewModel.didTap = { model in
                tap(model)
            }
            
            return viewModel
        }
        
        return array
    }

    func didTapObject<T>(_ tap: @escaping ((T) -> Void)) -> [DSViewModel] {
        
        let array = self.map { (viewModel) -> DSViewModel in
            
            var viewModel = viewModel
            
            viewModel.didTap = { model in
                guard let object = model.object as? T else { return }
                tap(object)
            }
            
            return viewModel
        }
        
        return array
    }
}

public extension DSViewModel {

    mutating func didTap<T: DSViewModel>(_ tap: @escaping ((T) -> Void)) {
        
        didTap = { model in
            guard let model = model as? T else { return }
            tap(model)
        }
    }

    mutating func didTapObject<T>(_ tap: @escaping ((T) -> Void)) {
        
        didTap = { model in
            guard let object = model.object as? T else { return }
            tap(object)
        }
    }

    mutating func didTap(_ tap: @escaping ((DSViewModel) -> Void)) {
        
        didTap = { model in
            tap(model)
        }
    }
}
