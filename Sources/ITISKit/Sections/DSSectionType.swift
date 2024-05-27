import Foundation


public enum DSSectionType: Equatable, Hashable {
    case list
    case gallery(type: DSSectionGalleryType)
    case grid(columns: Int = 2)
}
