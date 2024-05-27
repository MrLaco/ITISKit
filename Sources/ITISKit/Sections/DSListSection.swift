import UIKit

public final class DSListSection: DSSection {

    public init(viewModels: [DSViewModel], separator: Bool = false) {
        super.init()
        
        if separator {
            self.viewModels = addSeparators(for: viewModels)
        } else {
            self.viewModels = viewModels
        }
        
        setUp()
    }

    public init(viewModels: [[DSViewModel]], separator: Bool = false) {
        super.init()
        
        if separator {
            self.viewModels = addSeparators(for: viewModels).flatMap({ $0 })
        } else {
            self.viewModels = viewModels.flatMap({ $0 })
        }
        
        setUp()
    }

    fileprivate func setUp() {
        let appearance = DSAppearance.shared.main
        insets = UIEdgeInsets(top: appearance.margins,
                              left: appearance.margins,
                              bottom: 0,
                              right: appearance.margins)
        type = .list
        interItemSpacing = appearance.interItemSpacing
    }

    fileprivate func addSeparators(for viewModels: [DSViewModel]) -> [DSViewModel] {
        
        var models = viewModels.map { (model) -> [DSViewModel] in
            return [model, separator(displayStyle: model.style.displayStyle)]
        }.flatMap({ $0 })
        
        if models.count > 0 {
            models.removeLast()
        }
        
        return models
    }

    fileprivate func addSeparators(for viewModels: [[DSViewModel]]) -> [[DSViewModel]] {
        var models = viewModels.map { (models) -> [DSViewModel] in
            var models = models
            models.append(separator(displayStyle: models.last?.style.displayStyle ?? .default))
            return models
        }
        models.removeLast()
        
        return models
    }

    fileprivate func separator(displayStyle: DSViewModelDisplayStyle) -> DSViewModel {
        var separator = DSSeparatorVM()
        separator.style.displayStyle = displayStyle
        separator.accessibilityIdentifier = "\(Int.random(in: 0...9999999))\(Int.random(in: 0...9999999))"
        return separator
    }
}


