//
//  NumbersViewController.swift
//  hotelCalifornia
//
//  Created by Dinmukhamed on 14.09.2023.
//

import UIKit

final class NumbersViewController: UIViewController {
    
    var viewModel: NumbersViewModelProtocol?
    
    lazy var numbersTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 600
        tableView.register(NumberTableViewCell.self, forCellReuseIdentifier: "NumberTableViewCell")
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        viewModel?.getNumbers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupSubviews() {
        [numbersTableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        numbersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel?.updateViewData = { [weak self] in
            DispatchQueue.main.async {
                self?.numbersTableView.reloadData()
            }
        }
    }
}

extension NumbersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rooms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberTableViewCell", for: indexPath) as? NumberTableViewCell else {
            return UITableViewCell() }
        
        cell.configure(configuration: (viewModel?.rooms[indexPath.row])!)
        
        cell.onTap = { [weak self] in
            self?.viewModel?.navigateToPaymentFlow()
        }
        
        return cell
        }
    }

