//
//  ImageViewController.swift
//  Cassini
//
//  Created by Echo Wang on 8/18/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    // create image view in storyboard, embeded in scrollView
    // @IBOutlet weak var imageView: UIImageView!
    
    // create scroll view in code, add image view as subview
    var imageView = UIImageView()
    @IBOutlet weak var scrollView: UIScrollView! {
        // as soon as the scrollView gets hooked by interface builder
        didSet {
            scrollView.addSubview(imageView)
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageURL: URL? {
        didSet {
            image = nil
            // only fetch image when it is on screen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    // if not on screen, eventually need to fetch image
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
           fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set zoom scale and delegate
        scrollView.minimumZoomScale = 1/25
        scrollView.maximumZoomScale = 1.0
        scrollView.delegate = self
        // load up some sample images
//        if imageView.image == nil {
//            imageURL = DemoURLs.boating
//        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            // fetch the image on queue other than main queue
            // ❗️weak self: avoid this closure holds self in the heap, if closure takes long time to run,
            // the user doesn't care about self, then I don't care about self anymore
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                // data objects are bags of bits
                // add try, because it may throw errors
                // try? try this thing and if it's fails, just return nil
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    // maybe someone changes the url when we are fetching the image, check the url
                    if let imageData = urlContents, url == self?.imageURL {
                        // UI things, put back in main queue
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            // resize 
            imageView.sizeToFit()
            // when preparing, it sets imageURL, but the outlet scrollView is not set yet, so use ?
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}
