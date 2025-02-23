import UIKit
import Combine


class DSSectionBackgroundDecorationView: UICollectionReusableView, Subscriber {

    typealias Input = DSDesignable
    typealias Failure = Never
    
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    public func receive(_ input: Input) -> Subscribers.Demand {
        configure()
        return .none
    }
    
    public func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion: \(completion)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        DSAppearance.shared.appearancePublisher.subscribe(self)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension DSSectionBackgroundDecorationView {
    
    func configure() {
        let appearance = DSAppearance.shared.main
        backgroundColor = appearance.secondaryView.background
        layer.cornerRadius = appearance.secondaryView.cornerRadius
    }
}
