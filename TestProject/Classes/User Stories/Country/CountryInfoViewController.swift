//
//  CountryViewController.swift
//  TestProject
//
//  Created by Semen Matsepura on 12.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class CountryInfoViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel = CountryInfoViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        setupRx()
        viewModel.obtainCountry()
    }
    
    private func setupRx() {
        viewModel.country
            .asObservable()
            .map { $0.info }
            .bind(to: infoLabel.rx.text )
            .disposed(by: disposeBag)
        
        viewModel.activityIndicator.asObservable()
            .bind(to: PKHUD.sharedHUD.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .skip(1)
            .bind { [weak self] (errorText) in
                self?.showAlert(withMessage: errorText)
            }.disposed(by: disposeBag)
    }

    func showAlert(withMessage msg: String) {
        let alert = UIAlertController(title: "Внимание!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Повтор", style: .cancel, handler: { [weak self] _ in
            self?.viewModel.obtainCountry()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
