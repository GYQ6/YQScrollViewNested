//
//  YQScrollView.m
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/9.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import "YQScrollView.h"
#import <TYTabPagerBar.h>
#import <TYPagerController.h>
#import "UIViewController+YQProperty.h"
#import "YQSubControllerDelegate.h"

@interface YQScrollView ()<
UIGestureRecognizerDelegate,
UIScrollViewDelegate,
TYTabPagerBarDelegate,
TYTabPagerBarDataSource,
TYPagerControllerDelegate,
TYPagerControllerDataSource,
YQSubControllerDelegate>

@property (strong, nonatomic) NSArray *titleArr; /**<导航标题集合*/
@property (copy, nonatomic) NSString *subVCName; /**<导航标题集合*/
@property (nonatomic, strong) TYTabPagerBar *topPageBar;
@property (nonatomic, strong) TYPagerController *pagerController;

@end

@implementation YQScrollView

- (YQScrollView *)initWithFrame:(CGRect)frame configSegmentedTitles:(NSArray *)titleArr configPageControllerSubController:(NSString *)subVC {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.titleArr = titleArr;
        self.subVCName = subVC;
        self.kHeaderViewHeight = 150; //设置默认悬停高度
        [self configSubUI];
        [self.topPageBar reloadData];
        [self.pagerController reloadData];
    }
    return self;
}

- (void)configSubUI {
    [self addSubview:self.topPageBar];
    [[UIViewController currentViewController] addChildViewController:self.pagerController];
    [self addSubview:self.pagerController.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topPageBar.frame = CGRectMake(0, _kHeaderViewHeight, SCREEN_WIDTH, 44);
    self.pagerController.view.frame = CGRectMake(0, CGRectGetMaxY(self.topPageBar.frame), SCREEN_WIDTH, self.frame.size.height - 44);
}

- (TYTabPagerBar *)topPageBar {
    if (!_topPageBar) {
        _topPageBar = [[TYTabPagerBar alloc]init];
        _topPageBar.layout.barStyle = TYPagerBarStyleProgressView;
        _topPageBar.dataSource = self;
        _topPageBar.delegate = self;
        _topPageBar.layout.normalTextColor = [UIColor blackColor];
        _topPageBar.layout.selectedTextColor = [UIColor redColor];
        _topPageBar.layout.progressColor = [UIColor orangeColor];
        _topPageBar.layout.normalTextFont = [UIFont systemFontOfSize:14];
        _topPageBar.layout.selectedTextFont = [UIFont systemFontOfSize:14];
        _topPageBar.layout.cellSpacing = 0;
        _topPageBar.layout.cellEdging = 0;
        _topPageBar.layout.adjustContentCellsCenter = YES;
        [_topPageBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _topPageBar;
}

- (TYPagerController *)pagerController {
    if (!_pagerController) {
        _pagerController = [[TYPagerController alloc]init];
        _pagerController.layout.prefetchItemCount = 0;
        // pagerController.layout.autoMemoryCache = NO;
        // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
        _pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        _pagerController.dataSource = self;
        _pagerController.delegate = self;
        _pagerController.scrollView.bounces = NO;
    }
    return _pagerController;
}

- (void)setKHeaderViewHeight:(CGFloat)kHeaderViewHeight {
    if(_kHeaderViewHeight != kHeaderViewHeight) _kHeaderViewHeight = kHeaderViewHeight;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - TYTabPagerBarDelegate, TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar
{
    return _titleArr.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index
{
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _titleArr[index];
    return cell;
}

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    return 50;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index
{
    [self.pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource,TYPagerControllerDelegate
- (NSInteger)numberOfControllersInPagerController {
    return _titleArr.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    UIViewController *subVC = [NSClassFromString(_subVCName) new];
    subVC.subScrollViewDelegate = self;
    return subVC;
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated
{
    [self.topPageBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
    
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress
{
    [self.topPageBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIViewController *subVC = [self.pagerController.visibleControllers firstObject];
    UIScrollView *subScrollView = subVC.subScroller;
    if (subScrollView.contentOffset.y > 0 || offsetY > _kHeaderViewHeight) {
        self.contentOffset = CGPointMake(0.0, _kHeaderViewHeight);
    }
}

#pragma mark - YQSubControllerDelegate
- (void)subScrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.contentOffset.y < _kHeaderViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = false;
    }else {
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
