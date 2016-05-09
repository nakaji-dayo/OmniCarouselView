//
//  PagerView.swift
//  Pods
//
//  Created by daishi nakajima on 2016/04/01.
//
//

import UIKit

public class PagerView: UIView {
    var count: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    public var current: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    let margin:CGFloat = 4
    override func drawRect(rect: CGRect) {
        let height = self.frame.height
        let ctx = UIGraphicsGetCurrentContext();
        var x = (self.frame.width - (height + margin) * CGFloat(count)) / 2
        for i in 0..<count {
            CGContextAddEllipseInRect(ctx, CGRect(x: x, y: 0, width: height, height: height))
            if i == current {
                CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
            } else {
                CGContextSetFillColorWithColor(ctx, UIColor.lightGrayColor().CGColor)
            }
            CGContextFillPath(ctx);

            x += height + margin
        }
    }

}
