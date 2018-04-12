//
//  CountryListCoordinator.swift
//  TestProject
//
//  Created by Semen Matsepura on 12.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit
import RxSwift

class CountriesListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = CountriesListViewModel()
        let viewController = CountriesListViewController.initFromStoryboard(name: "Countries")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        viewModel.didSelectCountry
            .subscribe({ [weak self] in self?.showCountry(by: $0.element ?? "", in: navigationController) })
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showCountry(by name: String, in navigationController: UINavigationController) {
        let viewController = CountryInfoViewController.initFromStoryboard(name: "Country")
        viewController.viewModel.name = name
        navigationController.pushViewController(viewController, animated: true)
    }
}
