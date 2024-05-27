import UIKit
import Cartography

public final class CollectionView: UICollectionView {
    
    override public func layoutSubviews() {
            super.layoutSubviews()
        
        guard #available(iOS 14.3, *) else { return }

                subviews.forEach { subview in
                    guard
                        let scrollView = subview as? UIScrollView,
                        let minY = scrollView.subviews.map(\.frame.origin.y).min(),
                        let maxHeight = scrollView.subviews.map(\.frame.height).max(),
                        minY != scrollView.frame.minY || maxHeight > scrollView.frame.height
                    else { return }
                    
                    scrollView.contentInset.top = -minY
                    scrollView.frame.origin.y = minY
                    scrollView.frame.size.height = maxHeight
                }
        }
}

public class DSCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    var snapshot: NSDiffableDataSourceSnapshot<DSDiffableSection, DSViewModelDataSource>?

    public var view: CollectionView
    public var didSelectItemAt: ((IndexPath) -> (Void))?
    public var scrollViewDidScroll: ((UIScrollView) -> (Void))?
    public var scrollViewDidScrollForKeyboard: ((UIScrollView) -> (Void))?
    public var scrollViewDidZoom: ((UIScrollView) -> (Void))?

    var registeredCells = Array<String>()
    var registeredViews = Array<String>()
    var isKeyboardOnScreen: Bool = false

    public var storedContentInset: UIEdgeInsets?

    static let sectionBackgroundDecorationElementKind = "section-background-element-kind"
    static let sectionBackgroundColorPrimaryDecorationElementKind = "section-background-color-primary-element-kind"
    static let sectionBackgroundColorSecondaryDecorationElementKind = "section-background-color-secondary-element-kind"

    public var contentSizeDidUpdate: ((CGSize) -> Void)?

    var adaptedContent = [DSSection]()
    var originalContent = [DSSection]()
    var dataSource: UICollectionViewDiffableDataSource<DSDiffableSection, DSViewModelDataSource>!
    var additionalBottomContentSpace: CGFloat = 0
    var additionalTopContentSpace: CGFloat = 0

    public var position: DSCollectionViewPosition

    public init(position: DSCollectionViewPosition) {
        self.position = position
        self.view = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: .zero)
        self.setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.position = .center
        self.view = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: aDecoder)
        self.setUp()
    }

    func setUp() {
        
        self.view.delegate = self;
        self.addSubview(self.view)
        
        constrain(self, self.view) { superView, collectionView  in
            collectionView.edges == superView.edges
        }

        configureDataSource()
        configureSupplementaryViewDataSource()
        setCollectionViewLayout(createLayout(), animated: false)
        
        isPagingEnabled = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
    }

    open func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        view.setCollectionViewLayout(layout, animated: animated, completion: completion)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewModel = self.adaptedContent[indexPath.section].viewModels[indexPath.row]
        viewModel.didTap?(viewModel)
        
        if let closure = self.didSelectItemAt {
            closure(indexPath)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let viewModel = self.adaptedContent[indexPath.section].viewModels[indexPath.row]
            if viewModel.didTap != nil {
                UIView.animate(withDuration: 0.2) {
                    for view in cell.contentView.subviews {
                        for view in view.subviews {
                            if view is UILabel {
                                view.alpha = 0.5
                            }
                        }
                    }
                }
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.3) {
                for view in cell.contentView.subviews {
                    for view in view.subviews {
                        if view is UILabel {
                            view.alpha = 1.0
                        }
                    }
                }
            }
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.scrollViewDidScroll?(scrollView)
        self.scrollViewDidScrollForKeyboard?(scrollView)
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView)  {
        if let closure = self.scrollViewDidZoom {
            closure(scrollView)
        }
    }
}
