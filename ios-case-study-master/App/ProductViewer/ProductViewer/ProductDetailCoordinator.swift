//
//  ProductDetailCoordinator.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

final class ProductDetailCoordinator: TempoCoordinator {

    // MARK: Presenters, view controllers, view state.

    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }

    fileprivate var viewState: ProductDetailViewState {
        didSet {
            updateUI()
        }
    }

    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }

    let dispatcher: Dispatcher = Dispatcher()

    lazy var viewController: UIViewController = {
        return ProductDetailViewController.viewControllerFor(coordinator: self)
    }()

    // MARK: Init

    required init(listItemViewState: ListItemViewState) {
        viewState = ProductDetailViewState.initWith(listItemViewState)

        updateUI()
        registerListeners()
    }

    // MARK: ListCoordinator

    fileprivate func registerListeners() {
        dispatcher.addObserver(AddToCartPressed.self) { [weak self] e in
            let alert = UIAlertController(title: "Item added to cart!", message: "🛒", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.viewController.present(alert, animated: true, completion: nil)
        }

        dispatcher.addObserver(AddToWishListPressed.self) { [weak self] e in
            let alert = UIAlertController(title: "Item added to list!", message: "🎧", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.viewController.present(alert, animated: true, completion: nil)
        }

        dispatcher.addObserver(ZoomImage.self) { [weak self] e in

            let imageViewController: ImageViewerViewController = ImageViewerViewController.imageViewController(with: e.image)
            self?.viewController.present(imageViewController, animated: true)
        }
    }
}
