//
//  DemoURLs.swift
//  Cassini
//
//  Created by Echo Wang on 8/19/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import Foundation

struct DemoURLs
{
    // use local one image
    static let boating = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    
    //    static let stanford = URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/55/Stanford_Oval_September_2013_panorama.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA23212_hires.jpg",
            "Saturn" : "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA22950_hires.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
