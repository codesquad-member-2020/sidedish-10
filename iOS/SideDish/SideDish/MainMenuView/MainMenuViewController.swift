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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(decodeError),
                                               name: .DecodeError,
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
        switch error {
        case .DataEmpty:
            alertError(message: "데이터가 비었어요.")
            break
        case .InvalidStatusCode(let code):
            alertError(message: "\(code) 에러 발생했어요.")
            break
        case .InvalidURL:
            alertError(message: "URL이 유효하지 않아요.")
            break
        case .requestError:
            alertError(message: "요청을 보내는 중에 오류가 발생했어요.")
            break
        }
    }
    
    @objc func reloadSection(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {return}
        mainMenuTableView.reloadSections(IndexSet(index...index), with: .automatic)
    }
    
    @objc func decodeError() {
        alertError(message: "응답을 복호화 하는 도중 문제가 발생했어요.")
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuHeaderView") as? MainMenuHeader else {return UIView()}
        let sectionInfo = mainMenuDataSource.sideDishManager.sectionName(at: section)
        let contents = sectionInfo.components(separatedBy: "/")
        headerView.configureLabel(title: contents[0], content: contents[1])
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