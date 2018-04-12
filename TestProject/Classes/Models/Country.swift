//
//  Country.swift
//  TestProject
//
//  Created by Semen Matsepura on 12.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String
    let population: Int
    let borders: [String]
    let currencies: [Currency]
    
    init(with name: String) {
        self.name = name
        self.capital = ""
        self.population = 0
        self.borders = []
        self.currencies = []
    }
}
