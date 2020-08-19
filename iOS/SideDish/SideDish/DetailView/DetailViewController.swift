//
//  DetailViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Toaster
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailScrollView: UIScrollView!
    @IBOutlet weak var thumbnailStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var detailImageStackView: UIStackView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var specialPriceLabel: UILabel!
    
    static let id = "DetailViewController"
    var hashId: String?
    var titleText: String!
    private var dishInfo: DetailDish? {
        didSet {
            self.setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUseCase()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureUseCase() {
        guard let hashId = hashId else { return }
        DetailInfoUseCase().loadDetailDish(with: NetworkManager(),
                                         id: hashId,
                                         failureHandler: { self.errorHandling(error: $0) },
                                         completed: { self.dishInfo = $0 }
        )
    }
    
    private func setOriginPriceLabel(text original: String?) {
        if let original = original {
            let originPrice = original
            let attributedString = NSMutableAttributedString(string: originPrice)
            attributedString.addAttribute(.baselineOffset, value: 0, range: (originPrice as NSString).range(of: originPrice))
            attributedString.addAttribute(.strikethroughStyle, value: 1, range: (originPrice as NSString).range(of: originPrice))
            self.originalPriceLabel.attributedText = attributedString
        } else {
            originalPriceLabel.alpha = 0
        }
    }
    
    private func setupUI() {
        guard let model = dishInfo else { return }
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = self?.titleText
            self?.descriptionLabel.text = model.dishInfo.productDescription
            self?.mileageLabel.text = model.dishInfo.point
            self?.deliveryFeeLabel.text = model.dishInfo.deliveryFee
            self?.deliveryInfoLabel.text = model.dishInfo.deliveryInfo
        }
    }
    
    private func alert(title: String, message: String, confirmMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: confirmMessage, style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
        }
    }
    
    private func alertError(message: String) {
        self.alert(title: "문제가 생겼어요", message: message, confirmMessage: "넵...")
    }
    
    private func errorHandling(error: NetworkError) {
        alertError(message: error.message())
    }
}
