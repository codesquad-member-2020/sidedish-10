//
//  MainMenuViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    private var mainMenuDataSource =  MainMenuViewDataSource()
    private let sectionName = ["메인반찬 / 한그릇 뚝딱 메인 요리","국.찌개 / 김이 모락모락 국.찌개","밑반찬 / 언제 먹어도 든든한 밑반찬"]
    
    private func sectionName(at index: Int) -> String {
        return sectionName[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuTableView.delegate = self
        mainMenuTableView.dataSource = mainMenuDataSource
        configureUseCase()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadSection(_:)),
                                               name: .ModelInserted,
                                               object: nil)
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
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "MainMenuHeader") as? MainMenuHeaderCell else {return UITableViewCell()}
        cell.configuration(sectionInfo: sectionName[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension Notification.Name {
    static let InjectionModel = Notification.Name("InjectionModel")
}
