//
//  TwentyFiveCentsApp.swift
//  TwentyFiveCents
//
//  Created by Robert Reichel on 10/26/22.
//

import SwiftUI
import Foundation
import LaunchAtLogin
import Sparkle



final class CheckForUpdatesViewModel: ObservableObject {
    @Published var canCheckForUpdates = false

    init(updater: SPUUpdater) {
        updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }
}

// This is the view for the Check for Updates menu item
// Note this intermediate view is necessary for the disabled state on the menu item to work properly before Monterey.
// See https://stackoverflow.com/questions/68553092/menu-not-updating-swiftui-bug for more info
struct CheckForUpdatesView: View {
    @ObservedObject private var checkForUpdatesViewModel: CheckForUpdatesViewModel
    private let updater: SPUUpdater
    
    init(updater: SPUUpdater) {
        self.updater = updater
        
        // Create our view model for our CheckForUpdatesView
        self.checkForUpdatesViewModel = CheckForUpdatesViewModel(updater: updater)
    }
    
    var body: some View {
        Button("Check for Updates…", action: updater.checkForUpdates)
            .disabled(!checkForUpdatesViewModel.canCheckForUpdates)
    }
}

@main
struct TwentyFiveCentsApp: App {
    @StateObject var timeViewModel = TimeViewModel()
    @AppStorage("firstLaunch") var firstLaunch = true
    private let updaterController: SPUStandardUpdaterController

    init() {
        
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        if firstLaunch {
            LaunchAtLogin.isEnabled = true
        }
    }
    var body: some Scene {

        MenuBarExtra(timeViewModel.selectedString) {
                            // 3
            Button(timeViewModel.stringForTimespan(timespan: .fyQuarter)) {
                timeViewModel.selectedTimespan = .fyQuarter
            }.fontWeight(.heavy)
            Button(timeViewModel.stringForTimespan(timespan: .semester)) {
                timeViewModel.selectedTimespan = .semester
            }.if(timeViewModel.selectedTimespan == .semester) { view in
                view.fontWeight(.bold)
            }
            Button(timeViewModel.stringForTimespan(timespan: .gregorianQuarter)) {
                timeViewModel.selectedTimespan = .gregorianQuarter
            }.if(timeViewModel.selectedTimespan == .gregorianQuarter) { view in
                view.fontWeight(.bold)
            }
            Divider()
            LaunchAtLogin.Toggle()
            Button("Check for updates") {
                updaterController.checkForUpdates(nil)
            }
//            CheckForUpdatesView(updater: updaterController.updater)
        }
//        switch timeViewModel.selectedView {
//        case .fyQuarter:
//
//
//        }
    }
}
