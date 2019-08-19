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
        scrollView.minimumZoomScale = 1/3
        scrollView.maximumZoomScale = 1.0
        scrollView.delegate = self
        // load up some sample images
        if imageView.image == nil {
            imageURL = DemoURLs.boating
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            // data objects are bags of bits
            // add try, because it may throw errors
            // try? try this thing and if it's fails, just return nil
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
}
