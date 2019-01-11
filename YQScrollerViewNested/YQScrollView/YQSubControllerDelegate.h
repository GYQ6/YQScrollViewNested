//
//  YQSubControllerDelegate.h
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/10.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YQSubControllerDelegate <NSObject>

@optional
- (void)subScrollViewWillBeginDraggin:(UIScrollView *)scrollView;
- (void)subScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)subScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
