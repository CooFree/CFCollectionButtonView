//
//  CFCollectionBtnViewTypeImageTitleCell.m
//  CFCollectionButtonView
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFCollectionBtnViewTypeImageTitleCell.h"
#import "CFKit_Define.h"
#import "CFCollectionBtnModel.h"

@interface CFCollectionBtnViewTypeImageTitleCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView_w;
@property(nonatomic, strong) UIView *lineView_h;

@end

@implementation CFCollectionBtnViewTypeImageTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.titleLabel.hidden = NO;
    self.imageView.hidden = NO;

    self.lineView_w.backgroundColor = CFKit_Color_Gray_11;
    self.lineView_h.backgroundColor = CFKit_Color_Gray_11;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat view_w = self.bounds.size.width;
    CGFloat view_h = self.bounds.size.height;

    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;

    min_w = 40;
    min_h = min_w;
    min_x = (view_w - min_w)/2;
    min_y = 20;
    self.imageView.frame = CFKit_CGRectFlatMake(min_x, min_y, min_w, min_h);

    min_x = 0;
    min_y = CGRectGetMaxY(self.imageView.frame) + 5;
    min_w = view_w - self.cf_gridView_lineWidth;
    min_h = 20;
    self.titleLabel.frame = CFKit_CGRectFlatMake(min_x, min_y, min_w, min_h);

    min_x = view_w - self.cf_gridView_lineWidth;
    min_y = 0;
    min_w = self.cf_gridView_lineWidth;
    min_h = view_h;
    self.lineView_h.frame = CFKit_CGRectFlatMake(min_x, min_y, min_w, min_h);

    min_x = 0;
    min_y = view_h - self.cf_gridView_lineWidth;
    min_w = view_w;
    min_h = self.cf_gridView_lineWidth;
    self.lineView_w.frame = CFKit_CGRectFlatMake(min_x, min_y, min_w, min_h);
}

#pragma mark - setter / getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = CFKit_Color_Clear;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIView *)lineView_w
{
    if (!_lineView_w)
    {
        _lineView_w = [UIView new];

        [self.contentView addSubview:_lineView_w];
    }
    return _lineView_w;
}

- (UIView *)lineView_h
{
    if (!_lineView_h)
    {
        _lineView_h = [UIView new];

        [self.contentView addSubview:_lineView_h];
    }
    return _lineView_h;
}

- (void)setModel:(CFCollectionBtnModel *)model
{
    _model = model;

    self.imageView.image = CFKit_ImageName(model.imageName);
    self.titleLabel.text = model.titleString;

}

- (void)setCf_gridView_titleColor:(UIColor *)cf_gridView_titleColor
{
    _cf_gridView_titleColor = cf_gridView_titleColor;

    self.titleLabel.textColor = cf_gridView_titleColor;
}

- (void)setCf_gridView_lineColor:(UIColor *)cf_gridView_lineColor
{
    _cf_gridView_lineColor = cf_gridView_lineColor;

    self.lineView_w.backgroundColor = cf_gridView_lineColor;
    self.lineView_h.backgroundColor = cf_gridView_lineColor;
}

- (void)setCf_gridView_lineWidth:(CGFloat)cf_gridView_lineWidth
{
    _cf_gridView_lineWidth = cf_gridView_lineWidth;
}

@end
