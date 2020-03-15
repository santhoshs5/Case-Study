//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ListItemPressed: EventType {
    
    let item : ListItemViewState
}


/// Added by Santhosh
struct ShowListLoading: EventType {}
struct HideListLoading: EventType {}
struct ListFetchError: EventType {}
struct EmptyList: EventType {}

