//
//  TYTabTitleViewCell.m
//  TYPagerControllerDemo
//
//  Created by tany on 16/5/4.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "TYTabPagerBarCell.h"

@interface TYTabPagerBarCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation TYTabPagerBarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTabTitleLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addTabTitleLabel];
    }
    return self;
}

- (void)addTabTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
}

-(void)configTabBadgeLabel:(NSString *)badgeNum
{
    if ([badgeNum intValue]==0||badgeNum==nil)
    {
        self.badgeLabel.hidden = YES;
    }
    else
    {
        self.badgeLabel.hidden = NO;
        if ([badgeNum integerValue]>99)
        {
            badgeNum = @"99";
        }
        self.badgeLabel.text = badgeNum;
    }
}

+ (NSString *)cellIdentifier {
    return @"TYTabPagerBarCell";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
}
-(UILabel *)badgeLabel
{
    if (!_badgeLabel)
    {
        _badgeLabel = [[UILabel alloc]init];
//        if (IPHONE4||IPHONE5)
//        {
//            _badgeLabel.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)-28.0, 3, 16.0, 16.0);
//        }else
//        {
//        }
        _badgeLabel.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)-37.0, 3, 16.0, 16.0);
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.layer.cornerRadius = 8.0;
        _badgeLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_badgeLabel];
    }
    return _badgeLabel;
}

@end
