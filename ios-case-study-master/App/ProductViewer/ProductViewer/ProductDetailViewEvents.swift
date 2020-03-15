//
//  DetailViewEvents.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

struct AddToCartPressed: EventType {}

struct AddToWishListPressed: EventType {}

struct ZoomImage: EventType {
    let image : UIImage
}
