import Foundation

public extension Date {

    func stringFormatted(timeZoneAbbreviation: String? = nil,
                         dateStyle: DateFormatter.Style = .medium,
                         timeStyle: DateFormatter.Style = .short) -> String {
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        if let timeZone = timeZoneAbbreviation {
            formatter.timeZone = TimeZone(abbreviation: timeZone)
        }
        
        return formatter.string(from: self)
    }

    func stringFormattedDay(timeZoneAbbreviation: String = "GMT+0:00") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        dateFormatter.dateFormat = "dd"
        let dayString = dateFormatter.string(from: self)
        
        return dayString
    }

    func stringFormattedHour(timeZoneAbbreviation: String = "GMT+0:00") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        dateFormatter.dateFormat = "HH:mm"
        let dayString = dateFormatter.string(from: self)
        
        return dayString
    }

    func stringFormattedMonth(timeZoneAbbreviation: String = "GMT+0:00",
                              dateFormat: String = "MMMM") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        dateFormatter.dateFormat = dateFormat
        let monthString = dateFormatter.string(from: self)
        
        return monthString
    }

    func stringFormattedWeekDay(timeZoneAbbreviation: String = "GMT+0:00",
                                dateStyle: DateFormatter.Style = .medium,
                                dateFormat: String = "EEE") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateStyle = dateStyle
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    func stringFormattedYear(timeZoneAbbreviation: String = "GMT+0:00",
                             dateFormat: String = "YYYY") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        dateFormatter.dateFormat = dateFormat
        let yearString = dateFormatter.string(from: self)
        return yearString
    }
}

public extension Date {

    static func dateFrom(string dateString: String?,
                         dateFormat: String = "dd MM yyyy",
                         timeZoneAbbreviation: String = "GMT+0:00",
                         localeIdentifier: String = "en_US") -> Date? {
        
        guard let dateString = dateString else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation)
        let date = dateFormatter.date(from: dateString)
        
        return date
    }
}
