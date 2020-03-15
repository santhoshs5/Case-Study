//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher: Dispatcher = Dispatcher()
    
    private let apiService: DealsService = DealsService()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        registerListeners()
        updateState()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] event in
            let detailCoordinator: ProductDetailCoordinator = ProductDetailCoordinator(listItemViewState: event.item)
            self?.viewController.navigationController?.pushViewController(detailCoordinator.viewController,
                                                                          animated: true)
        }

        dispatcher.addObserver(ShowListLoading.self) { [weak self] _ in
            guard let self = self else { return }
            self.viewController.showLoading()
        }

        dispatcher.addObserver(HideListLoading.self) { [weak self] _ in
            guard let self = self else { return }
            self.viewController.hideLoading()
        }
        
        dispatcher.addObserver(ListFetchError.self) { [weak self] _ in
            guard let self = self else { return }
            self.viewController.showListLoadError()
        }

        dispatcher.addObserver(EmptyList.self) { [weak self] _ in
            guard let self = self else { return }
            self.viewController.showEmptyListState()
        }
        
    }
    
    func updateState() {
        dispatcher.triggerEvent(ShowListLoading())

        if let url: URL = URL(string: "https://target-deals.herokuapp.com/api/deals") {
            apiService.request(url) { [weak self] (result: APIResult<[ListItemViewState]>) in
                guard let self = self else { return }
                self.dispatcher.triggerEvent(HideListLoading())
                switch result {
                case .success(let productList):
                    if productList.count > 0 {
                        self.viewState.listItems = productList
                    }
                    else {
                        self.dispatcher.triggerEvent(EmptyList())
                    }
                case .failure:
                    self.dispatcher.triggerEvent(ListFetchError())
                }
            }
        }
        else {
            self.dispatcher.triggerEvent(ListFetchError())
        }
    }
}
