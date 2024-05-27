import Foundation

public extension Int {

    func timeString() -> String {
        
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        
        var minutesString = "\(minutes)"
        var secondsString = "\(seconds)"
        
        if minutesString.count == 1 {
            minutesString = "0\(minutesString)"
        }
        
        if secondsString.count == 1 {
            secondsString = "0\(secondsString)"
        }
        
        return "\(minutesString):\(secondsString)"
    }
}
