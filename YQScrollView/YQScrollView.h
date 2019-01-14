//
//  YQScrollView.h
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/9.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQScrollView : UIScrollView

@property (assign, nonatomic) CGFloat kHeaderViewHeight; /**<设headerViewHeight 即悬停高度*/

- (YQScrollView *)initWithFrame:(CGRect)rect configSegmentedTitles:(NSArray *)titleArr configPageControllerSubController:(NSString *)subVC;

@end
