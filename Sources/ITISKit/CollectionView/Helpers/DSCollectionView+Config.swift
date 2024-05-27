import Foundation

extension DSCollectionView {
    
    public var isPagingEnabled: Bool {
        get { view.isPagingEnabled }
        set { view.isPagingEnabled = newValue }
    }
    
    public var showsHorizontalScrollIndicator: Bool {
        get { view.showsHorizontalScrollIndicator }
        set { view.showsHorizontalScrollIndicator = newValue }
    }
    
    public var showsVerticalScrollIndicator: Bool {
        get { view.showsVerticalScrollIndicator }
        set { view.showsVerticalScrollIndicator = newValue }
    }    
}
