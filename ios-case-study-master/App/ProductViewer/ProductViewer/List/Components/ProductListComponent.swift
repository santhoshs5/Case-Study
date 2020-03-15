//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

private let kProductListViewHeight: CGFloat = 150.0

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?
    

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        
        if let imageURL: String = item.imageURL {
            view.productImage.loadImageWithShimmeringLoading(at: item.index, with: imageURL,
                                                             placeholderImageName: nil)
        }
        
        view.aisleLabel.text = item.aisle
        
        view.aisleLabel.layer.cornerRadius = view.aisleLabel.bounds.size.height / 2.0
        view.aisleLabel.layer.borderWidth = 1.0
        view.aisleLabel.layer.borderColor = HarmonyColor.targetNeutralGrayColor.cgColor
        
        view.shipLabel.textColor = HarmonyColor.targetJetBlackColor
        view.orLabel.textColor = HarmonyColor.targetNeutralGrayColor
        view.shipLabel.text = "ship"
        view.orLabel.text = "or"
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(item: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return kProductListViewHeight
    }
}


