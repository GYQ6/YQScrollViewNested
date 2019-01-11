//
//  UIViewController+YQProperty.h
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/10.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSubControllerDelegate.h"

@interface UIViewController (YQProperty)
@property (strong, nonatomic) UIScrollView *subScroller; /**<内部ScrollView*/
@property (assign, nonatomic) id <YQSubControllerDelegate>subScrollViewDelegate; /**<delegate*/

+ (UIViewController *)currentViewController;
@end
