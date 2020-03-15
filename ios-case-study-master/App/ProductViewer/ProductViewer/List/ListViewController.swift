//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ListViewController: UIViewController {
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    fileprivate var coordinator: TempoCoordinator!
    
    private lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .full, right: .full, bottom: .full, left: .full)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetFadeAwayGrayColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    private lazy var loadingIndicator: LoadingIndicator = {
        let loadingIndicator: LoadingIndicator = LoadingIndicator()
        return loadingIndicator
    }()
    
    private lazy var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = HarmonyColor.targetStarkWhiteColor
        
        view.addAndPinSubview(collectionView)
        view.addAndCenterSubview(loadingIndicator)
        view.addAndCenterSubview(label)
            
        collectionView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        title = "checkout"
        
        
        let components: [ComponentType] = [
            ProductListComponent()
        ]

        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)

        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]

    }
    
    func showLoading() {
        label.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        label.isHidden = true
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
    
    func showListLoadError() {
        label.isHidden = false
        label.text = "Something went wrong"
    }
    
    func showEmptyListState() {
        label.isHidden = false
        label.text = "There are no deals available."
    }
    
}

