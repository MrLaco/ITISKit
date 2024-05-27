public extension DSViewController {
    func isCurrentFormValid(_ validate: @escaping (Bool) -> Void) {
        collectionView.isCurrentFormValid(validate)
    }
}
