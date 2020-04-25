//
//  MainMenuViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import Toaster

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    private var mainMenuDataSource =  MainMenuViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUseCase()
        setupTableView()
        setupObserver()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadSection(_:)),
                                               name: .ModelInserted,
                                               object: nil)
    }
    
    private func setupTableView() {
        mainMenuTableView.delegate = self
        mainMenuTableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: "MenuHeaderView")
        mainMenuTableView.dataSource = mainMenuDataSource
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadMainDish(with: NetworkManager(), failureHandler: {self.errorHandling(error: $0)}) {model, index in
            DispatchQueue.main.async {
                self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
            }
        }
        
        SideDishUseCase.loadSideDish(with: NetworkManager(), failureHandler: {self.errorHandling(error: $0)}) {model, index in
            DispatchQueue.main.async {
                self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
            }
        }
        
        SideDishUseCase.loadSoupDish(with: NetworkManager(), failureHandler: {self.errorHandling(error: $0)}) {model, index in
            DispatchQueue.main.async {
                self.mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
            }
        }
    }
    
    private func alertError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "문제가 생겼어요", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "넵...", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    private func errorHandling(error: NetworkManager.NetworkError) {
        alertError(message: error.message())
    }
    
    @objc func reloadSection(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {return}
        mainMenuTableView.reloadSections(IndexSet(index...index), with: .automatic)
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuHeaderView") as? MainMenuHeader else {return UIView()}
        let sectionInfo = mainMenuDataSource.sideDishManager.sectionName(at: section)
        let contents = sectionInfo.components(separatedBy: "/")
        headerView.setTitleLabel(text: contents[0])
        headerView.setContentLabel(text: contents[1])
        headerView.index = section
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = mainMenuDataSource.sideDishManager.sideDish(indexPath: indexPath)
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        detailViewController.id = dish.id
        let text = "타이틀 메뉴 : \(dish.title)\n\(dish.specialPrice)"
        Toast(text: text).show()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension Notification.Name {
    static let InjectionModel = Notification.Name("InjectionModel")
}

extension MainMenuViewController: SectionTapped {
    func sectionTapped(headerView: MainMenuHeader, at section: Int, title: String) {
        let numOfRows = mainMenuDataSource.sideDishManager.numOfRows(at: section)
        Toast(text: "\(title): \(numOfRows)개").show()
    }
}
