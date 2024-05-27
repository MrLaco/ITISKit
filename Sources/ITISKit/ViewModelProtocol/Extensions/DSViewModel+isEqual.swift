import Foundation

public extension DSViewModel {

    func isEqual(to object: DSViewModel) -> Bool {
        return false
    }
}

public extension Array where Element == DSViewModel {

    func isEqual(to array: [DSViewModel]) -> Bool {
        
        if self.count != array.count {
            return false
        }
        
        for (index, element) in self.enumerated() {
            let compareTo = array[index]
            if !element.isEqual(to: compareTo) {
                return false
            }
        }
        
        return true
    }
}
