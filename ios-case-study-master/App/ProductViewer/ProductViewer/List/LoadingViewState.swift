//
//  LoadingState.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 12/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

struct LoadingViewState: TempoViewState {

    private lazy var loadingIndicator: LoadingIndicator = {
        let loadingIndicator: LoadingIndicator = LoadingIndicator()
        loadingIndicator.dotColor = HarmonyColor.targetChoiceGreenColor
        
        return loadingIndicator
    }()
    
    mutating func animate() {
        loadingIndicator.startAnimating()
    }
    
}
