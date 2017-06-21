//
//  CFCollectionBtnView.m
//  CFCollectionButtonView
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFCollectionBtnView.h"
#import "CFKit_Define.h"
#import "CFCollectionBtnViewTypeImageTitleCell.h"
#import "CFCollectionBtnViewTypeTitleDescCell.h"

static NSString * const kCellID = @"CFCollectionBtnViewTypeImageTitleCell";
static NSString * const kCellID2 = @"CFCollectionBtnViewTypeTitleDescCell";

@interface CFCollectionBtnView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, assign) CGFloat gridItem_w;
@property(nonatomic, assign) CGFloat cf_gridView_lineWidth;

@end

@implementation CFCollectionBtnView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = CFKit_Color_Clear;
    self.collectionView.hidden = NO;

    // 默认配置
    self.gridViewType = CFCollectionBtnViewTypeTitleDesc;

    self.cf_gridView_rowCount = 4;
    self.cf_gridView_lineColor = CFKit_Color_Gray_10;
    self.cf_gridView_lineWidth = 0.5f;
    self.cf_gridView_titleColor = CFKit_Color_Black;
    self.cf_gridView_titleDescColor = CFKit_Color_Gray_9;
}

+ (instancetype)cf_creatGridViewWithGridViewType:(CFCollectionBtnViewType)gridViewType dataArray:(NSArray<CFCollectionBtnModel *> *)dataArray configurationBlock:(CFCollectionBtnView_configurationBlock)configurationBlock block:(CFCollectionBtnViewBlock)block
{
    CFCollectionBtnView *tempView = [[CFCollectionBtnView alloc] init];
    if (configurationBlock)
    {
        configurationBlock(tempView);
    }
    tempView.gridViewType = gridViewType;
    tempView.dataArray = dataArray;
    tempView.cf_gridViewBlock = block;

    return tempView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFCollectionBtnViewTypeImageTitleCell *cell;
    CFCollectionBtnViewTypeTitleDescCell *cell2;
    if (self.gridViewType == CFCollectionBtnViewTypeImageTitle)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
        cell.backgroundColor = CFKit_Color_Clear;
        cell.model = self.dataArray[indexPath.row];
        cell.cf_gridView_titleColor = self.cf_gridView_titleColor;
        cell.cf_gridView_lineWidth = self.cf_gridView_lineWidth;
        cell.cf_gridView_lineColor = self.cf_gridView_lineColor;

        return cell;
    }
    else if (self.gridViewType == CFCollectionBtnViewTypeTitleDesc)
    {
        cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID2 forIndexPath:indexPath];
        cell2.backgroundColor = CFKit_Color_White;
        cell2.model = self.dataArray[indexPath.row];
        cell2.cf_gridView_titleColor = self.cf_gridView_titleColor;
        cell2.cf_gridView_titleDescColor = self.cf_gridView_titleDescColor;
        cell2.cf_gridView_lineColor = self.cf_gridView_lineColor;
        cell2.cf_gridView_lineWidth = self.cf_gridView_lineWidth;

        return cell2;
    }

    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    CFCollectionBtnModel *model = self.dataArray[indexPath.row];

    if (self.cf_gridViewBlock)
    {
        self.cf_gridViewBlock(model, indexPath);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSizeMake(self.gridItem_w, self.cf_gridView_itemHeight));

    //    return BAKit_CGSizeFlatted(CGSizeMake(self.gridItem_w, self.ba_gridView_itemHeight));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - setter / getter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = CFKit_Color_Clear;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;

        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setGridViewType:(CFCollectionBtnViewType)gridViewType
{
    _gridViewType = gridViewType;

    if (self.gridViewType == CFCollectionBtnViewTypeImageTitle)
    {
        [_collectionView registerClass:[CFCollectionBtnViewTypeImageTitleCell class] forCellWithReuseIdentifier:kCellID];
    }
    else if (self.gridViewType == CFCollectionBtnViewTypeTitleDesc)
    {
        [_collectionView registerClass:[CFCollectionBtnViewTypeTitleDescCell class] forCellWithReuseIdentifier:kCellID2];
    }
    [self.collectionView reloadData];
}

- (void)setCf_gridView_rowCount:(NSInteger)cf_gridView_rowCount
{
    _cf_gridView_rowCount = cf_gridView_rowCount;
    //    self.gridItem_w = BAKit_Flat((BAKit_SCREEN_WIDTH - (ba_gridView_rowCount - 1) * self.ba_gridView_lineWidth)/ba_gridView_rowCount);
    self.gridItem_w = (CFKit_SCREEN_WIDTH - (cf_gridView_rowCount - 1) * self.cf_gridView_lineWidth)/cf_gridView_rowCount;

    [self.collectionView reloadData];
}

- (void)setCf_gridView_lineWidth:(CGFloat)cf_gridView_lineWidth
{
    _cf_gridView_lineWidth = cf_gridView_lineWidth;
    [self.collectionView reloadData];
}

- (void)setCf_gridView_itemHeight:(CGFloat)cf_gridView_itemHeight
{
    _cf_gridView_itemHeight = cf_gridView_itemHeight;
    [self.collectionView reloadData];
}

- (void)setCf_gridView_titleColor:(UIColor *)cf_gridView_titleColor
{
    _cf_gridView_titleColor = cf_gridView_titleColor;

    [self.collectionView reloadData];
}

- (void)setCf_gridView_titleDescColor:(UIColor *)cf_gridView_titleDescColor
{
    _cf_gridView_titleDescColor = cf_gridView_titleDescColor;

    [self.collectionView reloadData];
}

- (void)setCf_gridView_lineColor:(UIColor *)cf_gridView_lineColor
{
    _cf_gridView_lineColor = cf_gridView_lineColor;

    [self.collectionView reloadData];
}

- (void)setShowLineView:(BOOL)showLineView
{
    _showLineView = showLineView;

    if (!showLineView)
    {
        self.cf_gridView_lineWidth = 0;
        [self.collectionView reloadData];
    }
}

@end
