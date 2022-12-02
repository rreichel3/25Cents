import Foundation


public extension Date {
    var calendar: Calendar { Calendar.current }

  
    var quarter: Int {
        let month = Double(calendar.component(.month, from: self))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month / numberOfMonthsInQuarter))
    }

    var fyQuarter: Int {
        var dateComponent = DateComponents()
        dateComponent.month = 6
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        let month = Double(calendar.component(.month, from: futureDate))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return (Int(ceil(month / numberOfMonthsInQuarter)))
    }

    var semester: Int {
        var dateComponent = DateComponents()
        dateComponent.month = -3
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        let month = Double(calendar.component(.month, from: futureDate))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 2
        return (Int(ceil(month / numberOfMonthsInQuarter)))
    }
    
    var fiscalDate: Date {
        var dateComponent = DateComponents()
        dateComponent.month = 6
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    var fiscalYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        return formatter.string(from: fiscalDate)
    }
    var gregorianYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        return formatter.string(from: self)
    }
}
