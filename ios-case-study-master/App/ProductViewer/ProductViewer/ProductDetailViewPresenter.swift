//
//  ProductDetailViewPresenter.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

final class ProductDetailViewPresenter : TempoPresenter {
    
    // MARK: - Properties

    var dispatcher: Dispatcher?
    var detailViewController : ProductDetailViewController
    
    // MARK: - Init

    init(detailViewController : ProductDetailViewController,
          dispatcher: Dispatcher) {
        
        self.detailViewController = detailViewController
        self.dispatcher = dispatcher
        
        detailViewController.addToCartButton.layer.cornerRadius = 5.0
        detailViewController.addToCartButton.clipsToBounds = true
        
        detailViewController.addToListButton.layer.cornerRadius = 5.0
        detailViewController.addToCartButton.clipsToBounds = true
        
        detailViewController.navigationController?.navigationBar.tintColor = UIColor.targetStarkWhiteColor
    }
    
    // MARK: - Public methods

    func present(_ viewState: ProductDetailViewState) {
        detailViewController.priceLabel.text = viewState.price

        detailViewController.navigationItem.title = viewState.title
        detailViewController.descriptionTextView.text = viewState.description

        if let imageURL: String = viewState.imageURLString {
            self.detailViewController.itemImage.loadImageWithShimmeringLoading(at: viewState.index, with: imageURL,
                                                                               placeholderImageName: nil)
        }
    }
}
