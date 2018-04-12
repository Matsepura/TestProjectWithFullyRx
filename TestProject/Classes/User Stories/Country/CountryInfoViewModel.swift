//
//  CountryViewModel.swift
//  TestProject
//
//  Created by Semen Matsepura on 12.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import RxSwift

final class CountryInfoViewModel {
    var name = ""
    let service = CountriesService()
    let activityIndicator = ActivityIndicator()
    var country: Variable<CountryViewModel> = Variable(CountryViewModel())
    var error: Variable<String> = Variable("")
    private var disposeBag = DisposeBag()

    func obtainCountry() {
        service.obtainCountryInfo(by: name)
            .map { [weak self] country in
                CountryViewModel(country: country.first ?? Country(with: self?.name ?? "")) }
            .observeOn(MainScheduler.instance)
            .trackActivity(activityIndicator)
            .subscribe(onNext: { (viewModel) in
                self.country.value = viewModel
            }, onError: { [weak self] (error) in
                print(error.localizedDescription)
                self?.error.value = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
