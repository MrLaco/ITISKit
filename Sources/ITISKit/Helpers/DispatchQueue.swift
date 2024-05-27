import Foundation

public extension DispatchQueue {

    func randomDelay(min: TimeInterval = 0.0, max: TimeInterval = 1.0, _ closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: min...max)) {
            closure()
        }
    }

    func after(_ after: TimeInterval = 0.5, _ closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            closure()
        }
    }

    func now(_ closure: @escaping () -> Void) {
        self.after(0.0, closure)
    }
}
