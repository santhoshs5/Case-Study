//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo
import UIKit

final class ProductListView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var aisleLabel: UILabel!
    @IBOutlet weak var shipLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor(white: 224.0 / 255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
    }

}

extension ProductListView: ReusableNib {
    @nonobjc static let nibName = "ProductListView"
    @nonobjc static let reuseID = "ProductListViewIdentifier"

    @nonobjc func prepareForReuse() {
        productImage.image = nil
    }
}
    
