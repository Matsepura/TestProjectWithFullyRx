//
//  CountriesListViewModel.swift
//  TestProject
//
//  Created by Semen Matsepura on 11.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import RxSwift

final class CountriesListViewModel {
    let service = CountriesService()
    let activityIndicator = ActivityIndicator()
    var repositories: Variable<[CountryListViewModel]> = Variable([])
    var error: Variable<String> = Variable("")
    private var disposeBag = DisposeBag()
    
    // MARK: - Inputs
    let selectCountry: AnyObserver<CountryListViewModel>
    
    // MARK: - Outputs
    var didSelectCountry: Observable<String>
    
    init() {        
        let _selectCountry = PublishSubject<CountryListViewModel>()
        self.selectCountry = _selectCountry.asObserver()
        self.didSelectCountry = _selectCountry.asObservable()
            .map { $0.name }
    }

    func obtain() {
        service.obtainCountries()
            .map { repositories in repositories.map(CountryListViewModel.init)}
            .observeOn(MainScheduler.instance)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { (viewModels) in
                self.repositories.value = viewModels
            }, onError: { [weak self] (error) in
                print(error.localizedDescription)
                self?.error.value = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
