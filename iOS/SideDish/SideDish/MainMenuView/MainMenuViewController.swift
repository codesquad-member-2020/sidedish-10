//
//  MainMenuViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Floaty
import Toaster
import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    private var mainMenuDataSource = MainMenuViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupFloatingButton()
        setupTableView()
        setupObserver()
        setupDataSource()
        setupDishUseCase()
    }
    
    private func setupFloatingButton() {
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "PrimaryColor") ?? UIColor.cyan
        floaty.itemTitleColor = UIColor(named: "divisionColor") ?? UIColor.black
        self.view.addSubview(floaty)
    }
    
    private func setupDataSource() {
        mainMenuDataSource.handler = { cell, urlString in
            guard let requestURL = URL(string: urlString) else {
                self.errorHandling(error: .invalidURL)
                return
            }
            
            ImageUseCase().loadImage(with: NetworkManager(),
                                   from: requestURL,
                                   failureHandler: { self.errorHandling(error: $0) },
                                   completed: { cell.setImageFromData(data: $0) })
        }
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadSection(_:)),
                                               name: .ModelInserted,
                                               object: nil)
    }
    
    private func setupTableView() {
        mainMenuTableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: "MenuHeaderView")
        mainMenuTableView.dataSource = mainMenuDataSource
        mainMenuTableView.delegate = self
    }
    
    private func setupDishUseCase() {
        for typeIndex in 0..<MenuType.allCases.count {
            SideDishUseCase().loadDish(
                with: NetworkManager(),
                type: MenuType(index: typeIndex),
                failureHandler: { _ in },
                successHandler: { [weak self] dish in
                    self?.mainMenuDataSource.sideDishManager.insert(into: typeIndex, rows: dish)
            })
        }
    }
    
    private func alertError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "문제가 생겼어요", message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "넵...", style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
        }
    }
    
    private func errorHandling(error: NetworkError) {
        alertError(message: error.message())
    }
    
    @objc func reloadSection(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        DispatchQueue.main.sync { [weak self] in
            self?.mainMenuTableView.reloadSections(IndexSet(index...index), with: .automatic)
        }
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: DetailViewController.id) as? DetailViewController else { return }
        let dish = mainMenuDataSource.sideDishManager.sideDish(indexPath: indexPath)
        detailViewController.hashId = dish.id
        detailViewController.titleText = dish.title
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainMenuViewController: SectionTapped {
    func sectionTapped(headerView: MainMenuHeader, at section: Int, title: String) {
        let numOfRows = mainMenuDataSource.sideDishManager.numOfRows(at: section)
        Toast(text: "\(title): \(numOfRows)개").show()
    }
}
