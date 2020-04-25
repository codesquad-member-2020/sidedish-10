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
        mainMenuTableView.dataSource = mainMenuDataSource
        mainMenuTableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: "MenuHeaderView")
    }
    
    private func configureUseCase() {
        SideDishUseCase.loadDishes(with: NetworkManager(), failureHandler: { error in
            self.errorHandling(error: error)
        }) {model, index in
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
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuHeaderView") as? MainMenuHeader else {return UIView()}
        let contents = sectionName[section].components(separatedBy: "/")
        cell.configureLabel(title: contents[0], content: contents[1])
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
    func sectionTapped(at section: Int, title: String) {
        let numOfRows = mainMenuDataSource.sideDishManager.numOfRows(at: section)
        Toast(text: "\(title): \(numOfRows)개").show()
    }
}
