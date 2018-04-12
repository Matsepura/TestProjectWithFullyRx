//
//  CountriesService.swift
//  TestProject
//
//  Created by Semen Matsepura on 11.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxOptional

struct CountriesService {
    let provider = MoyaProvider<CountriesProvider>()

    func obtainCountries() -> Observable<[CountryList]> {
        return self.provider.rx
            .request(CountriesProvider.countriesList)
            .map([CountryList].self).asObservable()
            .retry(3)
    }
    
    func obtainCountryInfo(by name: String) -> Observable<[Country]> {
        return self.provider.rx
            .request(CountriesProvider.countryInfo(name: name))
            .map([Country].self).asObservable()
            .retry(3)
    }
}
