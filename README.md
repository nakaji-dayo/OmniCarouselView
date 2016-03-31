# OmniCarouselView

Carousel view that can contain UIImage, image url or any view

[![CI Status](http://img.shields.io/travis/nakaji-dayo/OmniCarouselView.svg?style=flat)](https://travis-ci.org/nakaji-dayo/OmniCarouselView)
[![Version](https://img.shields.io/cocoapods/v/OmniCarouselView.svg?style=flat)](http://cocoapods.org/pods/OmniCarouselView)
[![License](https://img.shields.io/cocoapods/l/OmniCarouselView.svg?style=flat)](http://cocoapods.org/pods/OmniCarouselView)
[![Platform](https://img.shields.io/cocoapods/p/OmniCarouselView.svg?style=flat)](http://cocoapods.org/pods/OmniCarouselView)

![demo movie](https://raw.githubusercontent.com/nakaji-dayo/OmniCarouselView/master/doc/OmniCarouselView.gif)

## Usage
1. `import OmniCarouselView`
2. Putting a UIView in InterfaceBuilder, then set Custom Class to `OmniCarouselView`
3. Please see following examples

## Examples
### UIImage
```
let images = [UIImage(named: "beer1"), UIImage(named: "beer2"), UIImage(named: "beer3")]
carouselView1.contents = images
  .filter({$0 != nil})
  .map({OmniCarouselView.Content.Image($0!)})
```
### from image url
```
let imageUrls = Array(1...3).map({i in NSURL(string: "https://raw.githubusercontent.com/nakaji-dayo/OmniCarouselView/master/Example/OmniCarouselView/Images.xcassets/beer\(i).imageset/beer\(i).jpeg")})
carouselView2.contents = imageUrls.filter({$0 != nil}).map({OmniCarouselView.Content.ImageUrl($0!)})
```
### other UIView
```
let labels = Array(0..<3).map { (i) -> UILabel in
    let label = UILabel()
    label.text = "label:\(i)"
    return label
}
carouselView3.contents = labels.map({OmniCarouselView.Content.View($0)})
```

## Installation

OmniCarouselView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OmniCarouselView"
```

## Customize

| key | type | description |
|----|----|----|
| infinite | Bool | use infinite loop paging(scrolling) |
| pager | Bool | show pager indicator |

## Author

nakaji-dayo, nakaji.dayo@gmail.com

## License

OmniCarouselView is available under the MIT license. See the LICENSE file for more info.

