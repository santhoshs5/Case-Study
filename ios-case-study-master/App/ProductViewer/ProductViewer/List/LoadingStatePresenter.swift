//
//  LoadingStatePresenter.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 12/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

class LoadingStatePresenter:NSObject, TempoPresenter {

    var loadingState: LoadingViewState
    
    init(with loadingState: LoadingViewState) {
        self.loadingState = loadingState
    }
    
    func present(_ viewState: LoadingViewState) {
        loadingState.animate()
    }
}
