//
//  CountryListCell.swift
//  TestProject
//
//  Created by Semen Matsepura on 11.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

final class CountryListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    func configure(with viewModel: CountryListViewModel) {
        selectionStyle = .none
        nameLabel.text = viewModel.name
        populationLabel.text = viewModel.population
    }
}
