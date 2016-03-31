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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let images = [UIImage(named: "beer1"), UIImage(named: "beer2"), UIImage(named: "beer3")]
        carouselView1.contents = images
            .filter({x in x != nil})
            .map({OmniCarouselView.Content.Image($0!)})
        
        let labels = Array(0..<3).map { (i) -> UILabel in
            let label = UILabel()
            label.text = "label:\(i)"
            return label
        }
        carouselView2.contents = labels.map({x in OmniCarouselView.Content.View(x)})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

