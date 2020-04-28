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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var detailImageStackView: UIStackView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    private var thumnailImageViews = [UIImageView]()
    private var detailImageViews = [UIImageView]()
    
    var id: Int!
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
    
    private func setupUI() {
        guard let model = model else {return}
        descriptionLabel.text = model.product_description
        mileageLabel.text = model.point
        deliveryFeeLabel.text = model.delivery_fee
        deliveryInfoLabel.text = model.delivery_info
        
        for from in model.thumb_images {
            let imageView = UIImageView()
            thumbnailStackView.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: thumbnailScrollView.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
            imageView.contentMode = .scaleAspectFill
            
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
            detailImageViews.append(imageView)
            detailImageStackView.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: contentScrollView.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
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
}

extension Notification.Name {
    static let p = Notification.Name("p")
}
