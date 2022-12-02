//
//  TimeViewModel.swift
//  TwentyFiveCents
//
//  Created by Robert Reichel on 10/26/22.
//

import Foundation
import SwiftUI

class TimeViewModel: ObservableObject {
    enum Timespan: String, CaseIterable {
        case fyQuarter
        case semester
        case gregorianQuarter
    }
    init() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
        selectedString = stringForTimespan(timespan: selectedTimespan)
    }
    @Published var now: Date = Date() {
        didSet {
            selectedString = stringForTimespan(timespan: selectedTimespan)
        }
    }
    
    @AppStorage("selectedTimespan") var selectedTimespan: Timespan = .fyQuarter {
        didSet {
            print("selectedTimespan")
            selectedString = stringForTimespan(timespan: selectedTimespan)
        }
    }
    
    @Published var selectedString: String = ""
    func stringForTimespan(timespan: Timespan) -> String {
        switch timespan {
        case .fyQuarter:
            return "FY\(now.fiscalYear)Q\(now.fyQuarter)"
        case .gregorianQuarter:
            return "Y\(now.gregorianYear)Q\(now.quarter)"
        case .semester:
            return "SEM\(now.semester)"
        }
    }
    //    @Published
    var timer = Timer()
    
    func selectTimespan(newTimespan: Timespan) {
        selectedTimespan = newTimespan
    }
    @objc func updateDate() {
        now = Date()
    }
    
    
}
