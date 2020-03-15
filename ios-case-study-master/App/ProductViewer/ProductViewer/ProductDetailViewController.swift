//
//  ProductDetailViewController.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

final class ProductDetailViewController: UIViewController {

    // MARK: - Properties

    fileprivate var coordinator: ProductDetailCoordinator!
    
    // MARK: - IBOutlets

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var addToListButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!

    // MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.presenters = [ProductDetailViewPresenter(detailViewController: self,
                                                             dispatcher: coordinator.dispatcher)]
        self.navigationController?.navigationBar.tintColor = HarmonyColor.targetBullseyeRedColor
        
    }

    // MARK: - IBActions

    @IBAction func addToWishList(_ sender: Any) {
        coordinator.dispatcher.triggerEvent(AddToWishListPressed())
    }

    @IBAction func addToCartTapped(_ sender: Any) {
        coordinator.dispatcher.triggerEvent(AddToCartPressed())
    }

    @IBAction func tapImage(_ sender: Any) {
        zoomIn()
    }
    
    // MARK: - Public methods

    func zoomIn() {
        if let itemImage = itemImage.image {
            coordinator.dispatcher.triggerEvent(ZoomImage(image: itemImage))
        }
    }
    
    // MARK: - Class methods

    class func viewControllerFor(coordinator: TempoCoordinator) -> UIViewController {
        let detailViewController: ProductDetailViewController = ProductDetailViewController(nibName: "ProductDetailViewController",
                                                                                            bundle: nil)
        detailViewController.coordinator = coordinator as? ProductDetailCoordinator

        return detailViewController
    }

}
