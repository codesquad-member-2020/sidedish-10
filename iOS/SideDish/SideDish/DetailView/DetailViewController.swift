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
    
    @IBAction func orderButtonPushed(_ sender: UIButton) {
        StockUseCase.isSoldOut(with: NetworkManager(),
                               id: id,
                               failureHandler: { self.errorHandling(error: $0) },
                               completed: {
                                if $0 {
                                    DispatchQueue.main.async {
                                        self.navigationController?.popViewController(animated: true)
                                        self.alert(title: "주문 성공!", message: self.titleText, confirmMessage: "넵!")
                                    }
                                } else {
                                    self.alert(title: "품절 입니다ㅠㅠ", message: "죄송합니다 흑흑", confirmMessage: "넵ㅠㅠ")
                                }
        })
    }
    
    var id: Int!
    var titleText: String!
    private var model: DishInfo? {
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUseCase(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureUseCase(id: Int) {
        DetailInfoUseCase.loadDetailDish(with: NetworkManager(),
                                         id: id,
                                         failureHandler: { self.errorHandling(error: $0) },
                                         completed: { self.model = $0 }
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
        guard let model = model else { return }
        titleLabel.text = titleText
        descriptionLabel.text = model.productDescription
        mileageLabel.text = model.point
        deliveryFeeLabel.text = model.deliveryFee
        deliveryInfoLabel.text = model.deliveryInfo
        
        for from in model.thumbImages {
            let imageView = UIImageView()
            insertImageView(into: thumbnailStackView, imageView: imageView, constraintAnchor: thumbnailScrollView)
            
            guard let url = URL(string: from) else {
                errorHandling(error: .invalidURL)
                return
            }
            
            ImageUseCase.loadImage(with: NetworkManager(),
                                   from: url,
                                   failureHandler: { self.errorHandling(error: $0) },
                                   completed: {
                                    let image = UIImage(data: $0)
                                    DispatchQueue.main.async {
                                        imageView.image = image
                                    }
            })
        }
        
        for from in model.detailSection {
            let imageView = UIImageView()
            insertImageView(into: detailImageStackView, imageView: imageView, constraintAnchor: contentScrollView)
            
            guard let url = URL(string: from) else {
                errorHandling(error: .invalidURL)
                return
            }
            
            ImageUseCase.loadImage(with: NetworkManager(),
                                   from: url,
                                   failureHandler: { self.errorHandling(error: $0) },
                                   completed: {
                                    let image = UIImage(data: $0)
                                    DispatchQueue.main.async {
                                        imageView.image = image
                                        imageView.heightAnchor.constraint(equalToConstant: imageView.frame.width * (image?.size.height ?? 1) / (image?.size.width ?? 1)).isActive = true
                                    }
            })
        }
    }
    
    private func insertImageView(into stackView: UIStackView, imageView: UIImageView, constraintAnchor: UIScrollView) {
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: constraintAnchor.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
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
    
    private func errorHandling(error: NetworkManager.NetworkError) {
        alertError(message: error.message())
    }
}
