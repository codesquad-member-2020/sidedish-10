//
//  DetailViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import Toaster
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
        StockUseCase.isSoldOut(with: NetworkManager(), id: id, failureHandler: {self.errorHandling(error: $0)}) {
            print($0)
        }
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
        DetailInfoUseCase.loadDetailDish(with: NetworkManager(), id: id, failureHandler: {self.errorHandling(error: $0)}) {
            self.model = $0
        }
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
        guard let model = model else {return}
        titleLabel.text = titleText
        descriptionLabel.text = model.product_description
        mileageLabel.text = model.point
        deliveryFeeLabel.text = model.delivery_fee
        deliveryInfoLabel.text = model.delivery_info
        setOriginPriceLabel(text: model.n_price)
        specialPriceLabel.text = model.s_price
        
        for from in model.thumb_images {
            let imageView = UIImageView()
            InsertImageView(into: thumbnailStackView, imageView: imageView, constraintAnchor: thumbnailScrollView)
            
            guard let url = URL(string: from) else {
                errorHandling(error: .InvalidURL)
                return
            }
            
            ImageUseCase.loadImage(with: NetworkManager(), from: url, failureHandler: {self.errorHandling(error:$0)}) {
                let image = UIImage(data: $0)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        
        for from in model.detail_section {
            let imageView = UIImageView()
            InsertImageView(into: detailImageStackView, imageView: imageView, constraintAnchor: contentScrollView)
            
            guard let url = URL(string: from) else {
                errorHandling(error: .InvalidURL)
                return
            }
            
            ImageUseCase.loadImage(with: NetworkManager(), from: url, failureHandler: {self.errorHandling(error:$0)}) {
                let image = UIImage(data: $0)
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.heightAnchor.constraint(equalToConstant: imageView.frame.width * (image?.size.height ?? 1) / (image?.size.width ?? 1)).isActive = true
                }
            }
        }
    }
    
    private func InsertImageView(into stackView: UIStackView, imageView: UIImageView, constraintAnchor: UIScrollView) {
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: constraintAnchor.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
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
}
