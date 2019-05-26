import Foundation

extension Date {
    var day: DateInterval? {
        return Calendar.current.dateInterval(of: .day, for: self)
    }
}

func getDay(year: Int, month: Int, day: Int) -> DateInterval? {
    return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))?.day
}
