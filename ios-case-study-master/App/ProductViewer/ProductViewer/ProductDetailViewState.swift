//
//  ProductDetailViewState.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

struct ProductDetailViewState: TempoViewState {

    let price: String
    let description: String
    let title: String
    let imageURLString: String?
    let index: Int
}


extension ProductDetailViewState {

    static func initWith(_ listItemViewState: ListItemViewState) -> ProductDetailViewState {
        return ProductDetailViewState(price: listItemViewState.price,
                                      description: listItemViewState.description,
                                      title: listItemViewState.title,
                                      imageURLString: listItemViewState.imageURL,
                                      index: listItemViewState.index)
    }
}
