//
//  CFCollectionBtnViewTypeImageTitleCell.h
//  CFCollectionButtonView
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFCollectionBtnModel;

@interface CFCollectionBtnViewTypeImageTitleCell : UICollectionViewCell

@property(nonatomic, strong) CFCollectionBtnModel *model;
@property(nonatomic, strong) UIColor *cf_gridView_titleColor;

/**
 item：分割线颜色
 */
@property(nonatomic, strong) UIColor *cf_gridView_lineColor;

@property(nonatomic, assign) CGFloat cf_gridView_lineWidth;

@end
