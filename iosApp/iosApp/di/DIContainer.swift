//
//  DIContainer.swift
//  safar-ios
//
//  Created by KARAN SHARMA on 05/05/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Swinject
import shared
import Combine

final class DIContainer: ObservableObject {
    static let instance = DIContainer()
    
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = container.resolve(type) else {
            fatalError("Dependency of type \(type) not registered.")
        }
        return dependency
    }
    
    private func registerDependencies() {
        container.register(GoalLogsViewModel.self) { _ in
            do {
                return try DiBridgeKt.getGoalLogsViewModel()
            } catch {
                fatalError("Failed to resolve GoalLogsViewModel: \(error)")
            }
        }.inObjectScope(.transient)
    }
}
