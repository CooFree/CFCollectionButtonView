//
//  CFCollectionBtnView.h
//  CFCollectionButtonView
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFCollectionBtnModel.h"

@class CFCollectionBtnView;
/**
 宫格样式

 - CFCollectionBtnViewTypeImageTitle: 上面是图片，下面是文字
 - CFCollectionBtnViewTypeTitleDesc: 上下都是文字，上面标题字体大，下面是详情字体小
 */
typedef NS_ENUM(NSUInteger, CFCollectionBtnViewType) {
    CFCollectionBtnViewTypeImageTitle = 0,
    CFCollectionBtnViewTypeTitleDesc
};

/**
 CFCollectionBtnView 回调

 @param model 返回 CFCollectionBtnModel
 @param indexPath indexPath
 */
typedef void (^CFCollectionBtnViewBlock)(CFCollectionBtnModel *model, NSIndexPath *indexPath);

/**
 CFCollectionBtnView 配置回调

 @param tempView CFCollectionBtnView
 */
typedef void (^CFCollectionBtnView_configurationBlock)(CFCollectionBtnView *tempView);


@interface CFCollectionBtnView : UIView

/**
 宫格样式，默认：CFCollectionBtnViewTypeImageTitle
 */
@property(nonatomic, assign) CFCollectionBtnViewType gridViewType;

/**
 数据源：来自 CFCollectionBtnModel
 */
@property(nonatomic, strong) NSArray <CFCollectionBtnModel *>*dataArray;

/**
 item：点击回调
 */
@property(nonatomic, copy)   CFCollectionBtnViewBlock cf_gridViewBlock;

/**
 item：高度
 */
@property(nonatomic, assign) CGFloat cf_gridView_itemHeight;

/**
 item：每行 item 的个数，默认为4个
 */
@property(nonatomic, assign) NSInteger cf_gridView_rowCount;

/**
 item：title 颜色，默认：CFKit_Color_Black【[UIColor blackColor]】
 */
@property(nonatomic, strong) UIColor *cf_gridView_titleColor;

/**
 item：Desc 颜色，默认：CFKit_Color_Gray_9【CFKit_Color_RGB(216, 220, 228)】
 */
@property(nonatomic, strong) UIColor *cf_gridView_titleDescColor;

/**
 item：分割线颜色，默认：CFKit_Color_Gray_10【CFKit_Color_RGB(240, 240, 240)】
 */
@property(nonatomic, strong) UIColor *cf_gridView_lineColor;

/**
 item：是否显示分割线
 */
@property(nonatomic, assign, getter=isShowLineView) BOOL showLineView;


/**
 快速创建宫格

 @param gridViewType 样式
 @param dataArray 数据
 @param configurationBlock 配置回调
 @param block 点击事件回调
 @return CFCollectionBtnView
 */
+ (instancetype)cf_creatGridViewWithGridViewType:(CFCollectionBtnViewType)gridViewType
                                       dataArray:(NSArray <CFCollectionBtnModel *>*)dataArray
                              configurationBlock:(CFCollectionBtnView_configurationBlock)configurationBlock
                                           block:(CFCollectionBtnViewBlock)block;


@end
