//
//  UIViewController+YQProperty.m
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/10.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import "UIViewController+YQProperty.h"
#import <objc/runtime.h>

static NSString *key_subScroller = @"subScroller";

static NSString *key_subScrollViewDelegate = @"subScrollViewDelegate";

@implementation UIViewController (YQProperty)


#pragma mark - set get 方法
- (void)setSubScroller:(UIScrollView *)subScroller {
    objc_setAssociatedObject(self, &key_subScroller, subScroller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)subScroller {
    return objc_getAssociatedObject(self, &key_subScroller);
}

- (void)setSubScrollViewDelegate:(id<YQSubControllerDelegate>)subScrollViewDelegate {
    objc_setAssociatedObject(self, &key_subScrollViewDelegate, subScrollViewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<YQSubControllerDelegate>)subScrollViewDelegate {
    return objc_getAssociatedObject(self, &key_subScrollViewDelegate);
}

#pragma mark - subScrollerDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.subScrollViewDelegate respondsToSelector:@selector(subScrollViewWillBeginDraggin:)]) {
        [self.subScrollViewDelegate subScrollViewWillBeginDraggin:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.subScrollViewDelegate respondsToSelector:@selector(subScrollViewDidScroll:)]) {
        [self.subScrollViewDelegate subScrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.subScrollViewDelegate respondsToSelector:@selector(subScrollViewDidEndDecelerating:)]) {
        [self.subScrollViewDelegate subScrollViewDidEndDecelerating:scrollView];
    }
}


//获取栈中最后一个vc
+ (UIViewController *)currentViewController{
    
    UIViewController * Rootvc = [UIApplication sharedApplication].delegate.window.rootViewController ;
    
    return [self currentViewControllerFrom:Rootvc];
}

+ (UIViewController *)currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)viewController;
        UIViewController * v = [nav.viewControllers lastObject];
        return [self currentViewControllerFrom:v];
    }else if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabVC = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:[tabVC.viewControllers objectAtIndex:tabVC.selectedIndex]];
    }else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}


@end
