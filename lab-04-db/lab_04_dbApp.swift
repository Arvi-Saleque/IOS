//
//  lab_04_dbApp.swift
//  lab-04-db
//
//  Created by macos on 1/2/26.
//

import SwiftUI
import Firebase	

@main
struct lab_04_dbApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
