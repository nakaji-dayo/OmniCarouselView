//
//  OmniCarouselView.swift
//  Pods
//
//  Created by daishi nakajima on 2016/03/31.
//
//

import UIKit

public class OmniCarouselView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public enum Content {
        case ImageUrl(NSURL)
        case Image(UIImage)
        case View(UIView)
    }
    
    let rightArrow = UIImageView(image: OmniCarouselView.loadImage("arrow-right"))
    let leftArrow = UIImageView(image: OmniCarouselView.loadImage("arrow-left"))
    
    public var contents: [Content] = [] {
        didSet {
            self.contentsChanged()
        }
    }
    
    let CellId = "carousel_cell"
    
    override public func awakeFromNib() {
        self.dataSource = self
        self.delegate = self
        self.registerClass(OmniCarouselViewCell.self, forCellWithReuseIdentifier: CellId)
        
        
        self.pagingEnabled = true
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .Horizontal
        }
    }    
    
    private func contentsChanged() {
        self.reloadData()
        if contents.count > 1 {
            self.showArrows()
        }
    }
    
    private func showArrows() {
        [leftArrow, rightArrow].forEach { (view) -> () in
            print(view.image)
            self.addSubview(view)
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                view.alpha = 0.0
            }) { (s) -> Void in
                view.removeFromSuperview()
            }
        }
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellId, forIndexPath: indexPath)
        if let cell = cell as? OmniCarouselViewCell {
            let c = contents[indexPath.row];
            cell.setContent(c)
        }
        return cell;
    }
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.bounds.size
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        rightArrow.frame = CGRect(x: self.frame.width - 48, y: self.frame.height/2 - 24, width: rightArrow.frame.width, height: rightArrow.frame.height)
        leftArrow.frame = CGRect(x: 0, y: self.frame.height/2 - 24, width: leftArrow.frame.width, height: leftArrow.frame.height)
    }
    
    class func loadImage(name: String) -> UIImage? {
        let podBundle = NSBundle(forClass: OmniCarouselView.self)
        if let url = podBundle.URLForResource("OmniCarouselView", withExtension: "bundle") {
            let bundle = NSBundle(URL: url)
            return UIImage(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)
        }
        return nil
    }
}
