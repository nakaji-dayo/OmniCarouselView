//
//  ViewController.swift
//  OmniCarouselView
//
//  Created by nakaji-dayo on 03/31/2016.
//  Copyright (c) 2016 nakaji-dayo. All rights reserved.
//

import UIKit
import OmniCarouselView

class ViewController: UIViewController {
    @IBOutlet weak var carouselView1: OmniCarouselView!
    @IBOutlet weak var carouselView2: OmniCarouselView!
    @IBOutlet weak var carouselView3: OmniCarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let images = [UIImage(named: "beer1"), UIImage(named: "beer2"), UIImage(named: "beer3")]
        carouselView1.contents = images
            .filter({$0 != nil})
            .map({OmniCarouselView.Content.Image($0!)})
        
        let imageUrls = Array(1...3).map({i in NSURL(string: "https://raw.githubusercontent.com/nakaji-dayo/OmniCarouselView/master/Example/OmniCarouselView/Images.xcassets/beer\(i).imageset/beer\(i).jpeg")})
        carouselView2.contents = imageUrls.filter({$0 != nil}).map({OmniCarouselView.Content.ImageUrl($0!)})
        
        let labels = Array(0..<3).map { (i) -> UILabel in
            let label = UILabel()
            label.text = "label:\(i)"
            return label
        }
        carouselView3.contents = labels.map({OmniCarouselView.Content.View($0)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

