//
//  CountryListViewModel.swift
//  TestProject
//
//  Created by Semen Matsepura on 11.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

class CountryListViewModel {
    let name: String
    let population: String
    
    init(country: CountryList) {
        self.name = country.name
        self.population = "👨‍👩‍👧‍👦\(country.population)"
    }
}
