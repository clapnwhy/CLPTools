# CLPTools

[![CI Status](http://img.shields.io/travis/clapnwhy/CLPTools.svg?style=flat)](https://travis-ci.org/clapnwhy/CLPTools)
[![Version](https://img.shields.io/cocoapods/v/CLPTools.svg?style=flat)](http://cocoapods.org/pods/CLPTools)
[![License](https://img.shields.io/cocoapods/l/CLPTools.svg?style=flat)](http://cocoapods.org/pods/CLPTools)
[![Platform](https://img.shields.io/cocoapods/p/CLPTools.svg?style=flat)](http://cocoapods.org/pods/CLPTools)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CLPTools is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CLPTools"
```

## Author

clapnwhy, 421822615@qq.com

## License

CLPTools is available under the MIT license. See the LICENSE file for more info.

---

## Architecture
* `CLPTools`
* `CLPToolsInterface`
* `CLPNav`
* `CLPNavgationBar`


## Usage

### CLPTools
头文件引用
```objective-c
#import <CLPTools/CLPTools.h>
```

### CLPToolsInterface

工具类，如： `CLPMd5` 的使用

#### CLPMd5

```objective-c

[CLPTools CLPMd5:@"123456" Sel16or32: 16 Islower: YES];
```


### CLPNav

自定义NavgationBar，如： `initNavBackgroundColor` 的使用

#### initNavBackgroundColor 先初始化

```objective-c

[CLPNav initNavBackgroundColor:[UIColor brownColor] andnavtitlecolor:[UIColor redColor]];

```
#### 显示Nav,Nav根控制需要使用

```objective-c

[CLPNav CLPNav_Show: self];

```

#### 显示Nav,Nav根控制需要使用

```objective-c

self.navigationItem.title = @"业主";

```











