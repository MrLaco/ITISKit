import Foundation

public extension DSTextComposer {

    func textViewModel() -> DSLabelVM {
        return DSLabelVM(composer: self)
    }

    func actionViewModel() -> DSActionVM {
        return DSActionVM(composer: self)
    }

    func checkboxActionViewModel(selected: Bool) -> DSActionVM {
        
        let appearance = DSAppearance.shared.main
        let icon = selected ? "checkmark.circle.fill" : "circle"
        let color = selected ? appearance.semanticGreenColor : appearance.secondaryView.text.subheadline.withAlphaComponent(0.5)
        
        var action = DSActionVM(composer: self)
        action.rightIcon(sfSymbolName: icon, style: selected ? .custom(size: 15, weight: .medium) : .custom(size: 12, weight: .light), tintColor: .custom(color))
        return action
    }
}
