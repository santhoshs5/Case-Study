//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    var isLoading: Bool = true
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable, Decodable {
    let title: String
    let price: String
    let imageURL: String?
    let identifier: String
    let salePrice: String?
    let guid: String
    let index: Int
    let aisle: String
    let description: String

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case identifier = "_id"
        case title
        case salePrice
        case price
        case index
        case imageURL = "image"
        case guid
        case description
        case aisle
    }

}

func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imageURL == rhs.imageURL
        && lhs.aisle == rhs.aisle
}
