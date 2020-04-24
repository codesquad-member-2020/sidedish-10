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
    private let sectionName = ["메인반찬 / 한그릇 뚝딱 메인 요리","국.찌개 / 김이 모락모락 국.찌개","밑반찬 / 언제 먹어도 든든한 밑반찬"]
    
    private func sectionName(at index: Int) -> String {
        return sectionName[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUseCase()
        setupTableView()
        setupObserver()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(injectModel(_:)),
                                               name: .InjectionModel,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadSection(_:)),
                                               name: .ModelInserted,
                                               object: nil)
    }
    
    private func setupTableView() {
        mainMenuTableView.delegate = self
        mainMenuTableView.dataSource = mainMenuDataSource
        mainMenuTableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: "MenuHeaderView")
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadDishes(with: NetworkManager()) {
            NotificationCenter.default.post(name: .InjectionModel, object: nil, userInfo: ["model" : $0, "index" : $1])
        }
    }
    
    @objc func reloadSection(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {return}
        mainMenuTableView.reloadSections(IndexSet(index...index), with: .automatic)
    }
    
    @objc func injectModel(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? [SideDishInfo] else {return}
        guard let index = notification.userInfo?["index"] as? Int else {return}
        mainMenuDataSource.sideDishManager.insert(into: index, rows: model)
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuHeaderView") as? MainMenuHeader else {return UIView()}
        cell.configureLabel(content: sectionName[section])
        cell.index = section
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = mainMenuDataSource.sideDishManager.sideDish(indexPath: indexPath)
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        detailViewController.dish = dish
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension Notification.Name {
    static let InjectionModel = Notification.Name("InjectionModel")
}

extension MainMenuViewController: SectionTapped {
    func sectionTapped(at section: Int, title: String) {
        let numOfRows = mainMenuDataSource.sideDishManager.numOfRows(at: section)
        Toast(text: "\(title): \(numOfRows)개").show()
    }
}
