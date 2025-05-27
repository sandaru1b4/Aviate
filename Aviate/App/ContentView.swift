//
//  ContentView.swift
//  Aviate
//
//  Created by Admin on 2025-05-27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: PROPERTIES
    @ObservedObject var appManager = AppManager()
    
    var body: some View {
        NavigationStack(path: $appManager.navigationPath) {
            AppManager.shared.setRootView()
                .navigationDestination(for: AppManager.Destination.self) { destination in
                    AppManager.shared.setViewForDestination(destination, appManager.getData())
                }
                .onAppear {
                    AppManager.shared.refreshState()
                }
        }
        .environmentObject(appManager)
    }
    
}


#Preview {
    ContentView()
}
