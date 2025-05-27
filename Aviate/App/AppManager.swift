//
//  AppManager.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import Foundation
import SwiftUI


final class AppManager: ObservableObject {
    
    public enum Destination: String {
        case login
        case signup
        case airlines
        case flightSchedule
        case flightData
    }
    
    // MARK: - SINGLETON
    static let shared: AppManager = AppManager()
    init(){}
    
    @Published var navigationPath = NavigationPath()
    
    private var data: Any?
    
    func navigate(to destination: Destination, _ data: Any? = nil) {
        self.data = data
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func getData() -> Any?{
        return data
    }
    
    // MARK: - GET UI VIEW FOR DESTINATION
    @ViewBuilder
    func setViewForDestination(_ destination: Destination, _ data: Any? = nil) -> some View {
        switch destination {
        case .login:
            EmptyView()
        case .signup:
            EmptyView()
        case .airlines:
            EmptyView()
        case .flightSchedule:
            EmptyView()
        case .flightData:
            EmptyView()
        }
    }
    
    func refreshState() {
        logAppManagerStatus()
    }
    
    func setRootView() -> some View {
        guard isAuthenticated else { return self.setViewForDestination(.login) }
        return self.setViewForDestination(.airlines)
    }
}


// MARK: - APP AUTH STATUS VALUES
extension AppManager {
    public var isAuthenticated: Bool {
        return PersistenceController.shared.loadUserData() != nil
    }
}

// MARK: - APP AUTHENTICATION TASKS
extension AppManager {
    func signIn(_ user: User) {
        deleteLocalData()
        setLocalData(for: user)
        refreshState()
    }
    
    func signUp(_ user: User) {
        deleteLocalData()
        setLocalData(for: user)
        refreshState()
    }
    
    func signOut() {
        deleteLocalData()
        refreshState()
    }
}

// MARK: - APP TASKS HELPERS
extension AppManager {
    func setLocalData(for user: User) {
        PersistenceController.shared.saveUserData(with: user)
    }
    
    func updateLocalData(for user: User) {
        PersistenceController.shared.updateUserData(with: user)
    }
    
    func deleteLocalData() {
        PersistenceController.shared.deleteUserData()
    }
    
    private func logAppManagerStatus() {
        print("CURRENT APP STATUS:")
        let log = { (_ status: String, _ value: Bool) in
            debugPrint(value ? "✅" : "❌", status, value ? "YES" : "NO")
        }
        log("AUTHENTICATED:", isAuthenticated)
    }
}
