//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Echo Wang on 8/19/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.content as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }

}

// add an navigation controller to add title in ipad
extension UIViewController {
    var content: UIViewController {
        if let navcon = self as? UINavigationController {
            // return navigation's visibleViewController
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
