//
//  EnvironmentApp.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

@main
struct EnvironmentApp: App {
    
    var body: some Scene {
        WindowGroup {
            MonitorView()
        }
        .windowToolbarStyle(.unified(showsTitle: false))
    }
}
