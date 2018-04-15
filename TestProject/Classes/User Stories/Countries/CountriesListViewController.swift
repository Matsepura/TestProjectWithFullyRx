//
//  CountriesListViewController.swift
//  TestProject
//
//  Created by Semen Matsepura on 11.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class CountriesListViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = CountriesListViewModel()
    private var disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries List"
        setupView()
        setupRx()
        refreshControl.sendActions(for: .valueChanged)
    }
    
    private func setupRx() {
        viewModel.countriesViewModels
            .asObservable()
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: "repoCell",
                                         cellType: CountryListCell.self))
            { [weak self] (_, viewModel, cell) in
                self?.setupCell(cell, viewModel: viewModel)
            }
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe({ [weak self] _ in self?.viewModel.obtain() })
            .disposed(by: disposeBag)
        
        viewModel.activityIndicator.asObservable()
            .bind(to: PKHUD.sharedHUD.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .skip(1)
            .bind { [weak self] (errorText) in
                self?.showAlert(withMessage: errorText)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CountryListViewModel.self)
            .bind(to: viewModel.selectCountry)
            .disposed(by: disposeBag)
    }
    
    private func setupCell(_ cell: CountryListCell, viewModel: CountryListViewModel) {
        cell.configure(with: viewModel)
    }
    
    private func setupView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    func showAlert(withMessage msg: String) {
        let alert = UIAlertController(title: "Внимание!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Повтор", style: .cancel, handler: { [weak self] _ in
            self?.refreshControl.sendActions(for: .valueChanged)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
