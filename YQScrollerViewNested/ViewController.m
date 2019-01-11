//
//  ViewController.m
//  YQScrollerViewNested
//
//  Created by GYQ on 2019/1/10.
//  Copyright © 2019年 gyq.com. All rights reserved.
//

#import "ViewController.h"
#import "YQScrollView.h"

#define KHeaderViewHeight 150
@interface ViewController ()

@property (strong, nonatomic) YQScrollView *scrollView; /**<外层*/

@property (strong, nonatomic) UIView *headerView; /**<headerView*/

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, KHeaderViewHeight + SCREEN_HEIGHT);
}

- (YQScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[YQScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) configSegmentedTitles:@[@"全部", @"分类1", @"分类2"] configPageControllerSubController:@"YQSubController"];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.kHeaderViewHeight = 180;
    }
    return _scrollView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
