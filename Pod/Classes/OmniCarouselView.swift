//
//  OmniCarouselView.swift
//  Pods
//
//  Created by daishi nakajima on 2016/03/31.
//
//

import UIKit

public class OmniCarouselView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    public enum Content {
        case ImageUrl(NSURL)
        case Image(UIImage)
        case View(UIView)
    }
    
    @IBInspectable var infinite: Bool = false
    
    let rightArrow = UIImageView(image: OmniCarouselView.loadImage("arrow-right"))
    let leftArrow = UIImageView(image: OmniCarouselView.loadImage("arrow-left"))
    
    public var contents: [Content] = [] {
        didSet {
            self.contentsChanged()
        }
    }
    private var loopContents: [Content]?
    private var positionFixed = false
    
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
        if infinite {
            // for infinite loop
            self.loopContents = self.contents
            if let item = self.contents.last {
                self.loopContents?.insert(item, atIndex: 0)
            }
            if let item = self.contents.first {
                self.loopContents?.append(item)
            }
            self.positionFixed = false
        } else {
            loopContents = nil
        }

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
        return loopContents?.count ?? contents.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellId, forIndexPath: indexPath)
        if let cell = cell as? OmniCarouselViewCell {
            let c = loopContents?[indexPath.row] ?? contents[indexPath.row];
            cell.setContent(c)
        }
        return cell;
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if  infinite && !self.positionFixed {
            self.positionFixed = true
            // scroll to default position for infinite loop
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            self.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        }
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
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Calculate where the collection view should be at the right-hand end item
        if let lContents = self.loopContents {
            let right = Int(self.frame.width) * (lContents.count - 1)
            if Int(scrollView.contentOffset.x) >= right {
                let indexPath = NSIndexPath(forItem: 1, inSection: 0)
                self.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            } else if (scrollView.contentOffset.x == 0)  {
                let indexPath = NSIndexPath(forItem: (lContents.count - 2), inSection: 0)
                self.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            }
        }
    }
}
