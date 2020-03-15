//
//  ImageViewerViewController.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 15/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

final class ImageViewerViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!

    // MARK: - Properties

    var image: UIImage?

    // MARK: - View life cycle

    override func viewDidLoad() {
        if let image: UIImage = image {
            imageView.image = image
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }

    // MARK: - class functions
    
    class func imageViewController(with image: UIImage) -> ImageViewerViewController {

        let imageViewerController: ImageViewerViewController = ImageViewerViewController(nibName: "ImageViewerViewController",
                                                                                         bundle: nil)

        imageViewerController.image = image

        return imageViewerController
    }
}

extension ImageViewerViewController {

    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2.0)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset

        let xOffset = max(0, (size.width - imageView.frame.width) / 2.0)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset

        view.layoutIfNeeded()
    }
}

extension ImageViewerViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}
