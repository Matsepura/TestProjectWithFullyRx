//
//  AppCoordinator.swift
//  TestProject
//
//  Created by Semen Matsepura on 12.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let repositoryListCoordinator = CountriesListCoordinator(window: window)
        return coordinate(to: repositoryListCoordinator)
    }
}
