//
//  ServerResponse.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 14/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

struct ServerResponse<T>: Decodable where T: Decodable {
    private(set) var data: T?
}
