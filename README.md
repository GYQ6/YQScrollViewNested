# YQScrollViewNested
scrollView 嵌套列表滚动视图 达到平滑滚动的效果 微博个人主页 以及各大外卖平台都有类似效果

实现原理:

最外层是个scrollView, headerView作为scrollView的子视图放在顶部, 然后是分类工具栏topBar 和 pageView
重点是解决外层scrollView 和 pageView中subScrollView 收拾冲突

最初尝试用scrollView的scrollEnabled属性 控制外层和内部滚动视图滚动时机, 在代理方法<code> scrollViewDidScroll </code>中进行判断，外层scrollView 划出 150 后，停止响应滚动，这时手指再滑动，自然就是展示内容的 subScrollView 响应了。 用户并不总是完美的在滑动了 150 pt后，停下手。然后再开始进行下一次的滑动。如果用户一次性滚了 160 ，外层ScrollView 就会在滚动到 150 后停止响应，此时因为是一次手势， subScrollView 也不会响应。用户就会有被中断的感觉，需要第二次滑动才能继续滚动

so换了一种思路, 首先在外层scrollView中 通过手势的代理方法允许外层scrollView和内部ScrollView同时响应滚动手势,

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

然后用contentOffset 控制滚动时机

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIViewController *subVC = [self.pagerController.visibleControllers firstObject];
    UIScrollView *subScrollView = subVC.subScroller;
    if (subScrollView.contentOffset.y > 0 || offsetY > _kHeaderViewHeight) 
    {
        self.contentOffset = CGPointMake(0.0, _kHeaderViewHeight);
    }
}

#pragma mark - YQSubControllerDelegate

- (void)subScrollViewDidScroll:(UIScrollView *)scrollView
    {
    if (self.contentOffset.y < _kHeaderViewHeight) 
                                                  {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = false;
    }else 
                                                  {
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

















