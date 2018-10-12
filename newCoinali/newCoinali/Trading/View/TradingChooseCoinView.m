//
//  TradingChooseCoinView.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/11.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "TradingChooseCoinView.h"
#import "chooseCoinView.h"
@interface  TradingChooseCoinView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property  (nonatomic,strong)MTBaseTableView  *  tableView  ;
@property  (nonatomic,strong)NSMutableArray  *   dataList;
@end
@implementation TradingChooseCoinView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];
        
        UIView *baseView = [UIView new];
        baseView.backgroundColor = cBgColor ;
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.equalTo(self);
            make.height.mas_equalTo(400/375.0 * MainScreenW);
        }];
        
        chooseCoinView *coninView = [[chooseCoinView alloc] initWithFrame:CGRectZero btnArr:@[MyLocalized(@"optional"),MyLocalized(@"ETC"),MyLocalized(@"BTC"),MyLocalized(@"HKT")]];
        [baseView addSubview:coninView];
        [coninView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(MainScreenW);
            make.height.mas_equalTo(40);
            
        }];
        coninView.didClickedBlock = ^(NSInteger index) {
            [self.tableView.table reloadData];
        };
        
        [ self.tableView setupData:self.dataList index:4] ;
        [baseView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coninView.mas_bottom).with.offset(5);
            make.left.width.equalTo(baseView);
            make.height.mas_equalTo( 400/375.0 * MainScreenW - 45);
        }];
        
        
        
    }
    return self;
}
- (void)showView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0;
    [window addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
- (void)hiddenView
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = cBgColor ;
    
    
    NSArray *typeArr = @[MyLocalized(@"currency"),MyLocalized(@"The latest price"),MyLocalized(@"24 H Rise and fall")] ;
    for (int i = 0; i<typeArr.count; i++) {
        
        SMLabel *categoryLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cDarkBlueColor textFont:[UIFont fontWithName:@"PingFangSC-Medium" size:11]];
        categoryLB.text = typeArr[i];
        categoryLB.textAlignment = NSTextAlignmentLeft ;
        [view addSubview:categoryLB];
        categoryLB.frame = CGRectMake(0, 16, 100, 18);
   
        
            if (i==0) {
                categoryLB.left = 15 ;
            }else if (i==1){
                categoryLB.centerX = self.centerX ;
                categoryLB.textAlignment = NSTextAlignmentCenter ;
            }
            else {
                categoryLB.right = MainScreenW-15 ;
                categoryLB.textAlignment = NSTextAlignmentRight ;
            }
       
        
    };

    
    return view ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
#pragma mark - Setter/getter
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithObjects:@"12",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21", nil];//
    }
    return _dataList ;
}
- (MTBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MTBaseTableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenW, 400/375.0 * MainScreenW - 45) tableviewStyle:UITableViewStylePlain];
        _tableView.attribute = self;
        _tableView.table.delegate = self ;
        
    }
    return _tableView ;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenView];
}
@end
