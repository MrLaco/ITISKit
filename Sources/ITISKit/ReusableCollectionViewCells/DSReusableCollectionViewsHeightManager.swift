import UIKit


class DSReusableCollectionViewsHeightManager {

    private var heightDictionary: [String: CGFloat] = [:]
    private var widthDictionary: [String: CGFloat] = [:]

    static let shared = DSReusableCollectionViewsHeightManager()
    
    public init() {}

    func heightFor(viewModel: DSViewModel, in section: DSSection) -> CGFloat? {
        return heightDictionary[heightKey(for: viewModel, in: section)]
    }

    func setFor(height: CGFloat, viewModel: DSViewModel, in section: DSSection) {
        return heightDictionary[heightKey(for: viewModel, in: section)] = height
    }

    private func heightKey(for viewModel: DSViewModel, in section: DSSection) -> String {
        
        let insetsHash = viewModel.style.displayStyle.viewInsets().stringHash()
        
        var hasher = Hasher()
        hasher.combine("Height")
        hasher.combine(viewModel.hash())
        hasher.combine(section.type.hashValue)
        hasher.combine(insetsHash)        
        return hasher.finalize().string()
    }

    func widthFor(viewModel: DSViewModel, in section: DSSection) -> CGFloat? {
        return heightDictionary[widthKey(for: viewModel, in: section)]
    }

    func setFor(width: CGFloat, viewModel: DSViewModel, in section: DSSection) {
        return widthDictionary[widthKey(for: viewModel, in: section)] = width
    }

    private func widthKey(for viewModel: DSViewModel, in section: DSSection) -> String {
        
        let insetsHash = viewModel.style.displayStyle.viewInsets().stringHash()
        
        var hasher = Hasher()
        hasher.combine("Width")
        hasher.combine(viewModel.hash())
        hasher.combine(section.type.hashValue)
        hasher.combine(insetsHash)
        return hasher.finalize().string()
    }
}
