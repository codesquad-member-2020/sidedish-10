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
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setupFloatingButton()
        setupTableView()
        setupObserver()
        setupDataSource()
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
            
            ImageUseCase.loadImage(with: NetworkManager(),
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setupSection),
                                               name: .SectionInserted,
                                               object: nil)
    }
    
    private func setupTableView() {
        mainMenuTableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: "MenuHeaderView")
        mainMenuTableView.dataSource = mainMenuDataSource
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadMainDish(with: NetworkManager(),
                                     failureHandler: { self.errorHandling(error: $0) },
                                     completed: { model, index in
                                        DispatchQueue.main.async {
                                            self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
                                        }
        })
        
        SideDishUseCase.loadSideDish(with: NetworkManager(),
                                     failureHandler: { self.errorHandling(error: $0) },
                                     completed: { model, index in
                                        DispatchQueue.main.async {
                                            self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
                                        }
        })
        
        SideDishUseCase.loadSoupDish(with: NetworkManager(),
                                     failureHandler: { self.errorHandling(error: $0) },
                                     completed: { model, index in
                                        DispatchQueue.main.async {
                                            self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
                                        }
        })
    }
    
    private func alertError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "문제가 생겼어요", message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "넵...", style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
        }
    }
    
    private func errorHandling(error: NetworkManager.NetworkError) {
        alertError(message: error.message())
    }
    
    @objc func reloadSection(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        mainMenuTableView.reloadSections(IndexSet(index...index), with: .automatic)
    }
    
    @objc func setupSection() {
        DispatchQueue.main.async {
            self.mainMenuTableView.reloadData()
        }
        configureUseCase()
    }
}

extension MainMenuViewController: SectionTapped {
    func sectionTapped(headerView: MainMenuHeader, at section: Int, title: String) {
        let numOfRows = mainMenuDataSource.sideDishManager.numOfRows(at: section)
        Toast(text: "\(title): \(numOfRows)개").show()
    }
}
