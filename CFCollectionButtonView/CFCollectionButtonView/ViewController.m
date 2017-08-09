//
//  ViewController.m
//  CFCollectionButtonView
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"
#import "CFCollectionBtnView.h"
#import "CFKit_Define.h"

static NSString * const kCellID = @"ViewControllerCell";

#define kGridView_rowCount   4
#define kGridView_itemHeight 100
#define kGridView_H          CFKit_getColumnCountWithArrayAndRowCount(self.gridDataArray, kGridView_rowCount) * kGridView_itemHeight

#define kGridView_rowCount2   2
#define kGridView_itemHeight2 80
#define kGridView_H2          CFKit_getColumnCountWithArrayAndRowCount(self.gridDataArray2, kGridView_rowCount2) * kGridView_itemHeight2

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) UIViewController *vc1;
@property(nonatomic, strong) UIViewController *vc2;

@property(nonatomic, strong) CFCollectionBtnView *gridView;
@property(nonatomic, strong) CFCollectionBtnView *gridView2;

@property(nonatomic, strong) NSMutableArray  <CFCollectionBtnModel *> *gridDataArray;
@property(nonatomic, strong) NSMutableArray  <CFCollectionBtnModel *> *gridDataArray2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }

    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    cell.textLabel.text = [msg stringByAppendingString:self.dataArray[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
        {
            self.gridView.hidden = NO;

            UIView *footView = [self.view viewWithTag:100];

            if (!footView)
            {
                footView = [UIView new];
                footView.backgroundColor = [UIColor redColor];
                footView.frame = CGRectMake(0, 0, CFKit_SCREEN_WIDTH, kGridView_H);
                footView.tag = 100;
                self.gridView.frame = footView.bounds;
                [footView addSubview:self.gridView];
            }

            self.tableView.tableFooterView = footView;
        }
            break;
        case 1:
        {
            UIView *footView = [self.view viewWithTag:101];

            if (!footView)
            {
                footView = [UIView new];
                footView.backgroundColor = [UIColor redColor];
                footView.frame = CGRectMake(0, 0, CFKit_SCREEN_WIDTH, kGridView_H2);
                footView.tag = 101;
                self.gridView2.frame = footView.bounds;
                [footView addSubview:self.gridView2];
            }

            self.tableView.tableFooterView = footView;
        }
            break;

        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    self.tableView.frame = self.view.bounds;

}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = CFKit_Color_Gray_11;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

        [self.view addSubview:self.tableView];



        self.gridView.frame = CGRectMake(0, 0, CFKit_SCREEN_WIDTH, kGridView_H);
        self.tableView.tableHeaderView = self.gridView;

        self.gridView2.frame = CGRectMake(0, 0, CFKit_SCREEN_WIDTH, kGridView_H2);
        self.tableView.tableFooterView = self.gridView2;
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
//        _dataArray = @[@"图上文下", @"两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字两行文字"];
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (CFCollectionBtnView *)gridView
{
    if (!_gridView)
    {
        _gridView = [CFCollectionBtnView cf_creatGridViewWithGridViewType:CFCollectionBtnViewTypeImageTitle dataArray:self.gridDataArray configurationBlock:^(CFCollectionBtnView *tempView) {

            // 是否显示分割线
//            tempView.showLineView = NO;
            // item：分割线颜色，默认：CFKit_Color_Gray_11【CFKit_Color_RGB(248, 248, 248)】
                        tempView.cf_gridView_lineColor = CFKit_Color_Gray_9;

            // item：每行 item 的个数，默认为4个
            tempView.cf_gridView_rowCount = kGridView_rowCount;
            // item：高度
            tempView.cf_gridView_itemHeight = kGridView_itemHeight;
            //  item：title 颜色，默认：CFKit_Color_Black【[UIColor blackColor]】
            //            tempView.ba_gridView_titleColor = CFKit_Color_Black;

            self.gridView = tempView;

        } block:^(CFCollectionBtnModel *model, NSIndexPath *indexPath) {

            CFKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
        _gridView.backgroundColor = CFKit_Color_White;
    }
    return _gridView;
}

- (CFCollectionBtnView *)gridView2
{
    if (!_gridView2)
    {
        _gridView2 = [CFCollectionBtnView cf_creatGridViewWithGridViewType:CFCollectionBtnViewTypeTitleDesc
                                                        dataArray:self.gridDataArray2 configurationBlock:^(CFCollectionBtnView *tempView) {

                                                            // item：分割线颜色，默认：CFKit_Color_Gray_11【CFKit_Color_RGB(248, 248, 248)】
                                                            tempView.cf_gridView_lineColor = CFKit_Color_Gray_9;
                                                            // item：每行 item 的个数，默认为4个
                                                            tempView.cf_gridView_rowCount = kGridView_rowCount2;
                                                            // item：高度
                                                            tempView.cf_gridView_itemHeight = kGridView_itemHeight2;
                                                            //  item：title 颜色，默认：CFKit_Color_Black【[UIColor blackColor]】
                                                            tempView.cf_gridView_titleColor = CFKit_Color_Black;
                                                            //  item：Desc 颜色，默认：CFKit_Color_Gray_9【CFKit_Color_RGB(216, 220, 228)】
                                                            tempView.cf_gridView_titleDescColor = CFKit_Color_Gray_7;

                                                            self.gridView2 = tempView;

                                                        } block:^(CFCollectionBtnModel *model, NSIndexPath *indexPath) {

                                                            CFKit_ShowAlertWithMsg_ios8(model.titleString);
                                                        }];
        _gridView2.backgroundColor = CFKit_Color_Gray_10;
    }
    return _gridView2;
}

- (NSMutableArray <CFCollectionBtnModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;

        NSArray *imageNameArray = @[@"btn", @"btn2", @"btn3", @"btn4"];
        NSArray *titleArray = @[@"第一名", @"第二名", @"第三名", @"奖励"];

        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            CFCollectionBtnModel *model = [CFCollectionBtnModel new];
            model.imageName = imageNameArray[i];
            model.titleString = titleArray[i];

            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}

- (NSMutableArray <CFCollectionBtnModel *> *)gridDataArray2
{
    if (!_gridDataArray2)
    {
        _gridDataArray2 = @[].mutableCopy;

        NSArray *titleArray = @[@"100", @"200", @"300", @"400", @"500"];
        NSArray *descArray = @[@"面对面红包", @"信用卡还款", @"手机充值", @"火车票机票", @"电影演出赛事"];

        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            CFCollectionBtnModel *model = [CFCollectionBtnModel new];
            model.desc = descArray[i];
            model.titleString = titleArray[i];

            [_gridDataArray2 addObject:model];
        }
    }
    return _gridDataArray2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
