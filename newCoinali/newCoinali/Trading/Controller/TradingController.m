//
//  TradingController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "TradingController.h"
#import "BuyOrSellView.h"
#import "TradingDetailViewController.h"
#import "TradingChooseCoinView.h"
@interface TradingController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIButton * _foreBtn ;
}

@property (nonatomic , strong)UIScrollView *scrollerView ;
@property  (nonatomic,strong)MTBaseTableView  *  tableView  ;
@property  (nonatomic,strong)NSMutableArray  *   dataList;

@end

@implementation TradingController
#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItem];
    [self setUI];
}
- (void)setUI{
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.backgroundColor = cBgColor;
   self. scrollerView.scrollEnabled = YES;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.view);
    }];
    
    NSArray *buyOrsellArr = @[MyLocalized(@"buy"),MyLocalized(@"sell")];
    for (int i = 0; i<buyOrsellArr.count; i++) {
        UIButton *buyOrsellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyOrsellBtn setTitle:buyOrsellArr[i] forState:UIControlStateNormal];
        [buyOrsellBtn setTitleColor:cLightgreenColor forState:UIControlStateSelected];
        [buyOrsellBtn setTitleColor:cBrickRedColor forState:UIControlStateNormal];

        buyOrsellBtn.tag = 1+i ;
        [buyOrsellBtn addTarget:self action:@selector(buyOrSellClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollerView addSubview:buyOrsellBtn];
        [buyOrsellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollerView.mas_top).with.offset(10);
            make.left.equalTo(self.scrollerView.mas_left).with.offset(15 + i * (MainScreenW/2-15));
            make.width.mas_equalTo(MainScreenW/2-15);
            make.height.mas_equalTo(22);
            
        }];
        if (i==0) {
            buyOrsellBtn.selected = YES ;
            _foreBtn = buyOrsellBtn  ;
        }
        
        
    };
    UILabel *lineLB = [UILabel new];
    lineLB.backgroundColor = cLightgreenColor ;
    lineLB.tag = 99 ;
    [self.scrollerView addSubview:lineLB];
    [lineLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(MainScreenW/2-15);
        make.height.mas_equalTo(2);
    }];

    
    BuyOrSellView *topView = [[BuyOrSellView alloc] initWithFrame:CGRectZero];
    [self.scrollerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLB.mas_bottom).with.offset(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(MainScreenW);
        make.height.mas_equalTo(330);
    }];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blackColor];
    [self.scrollerView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(MainScreenW);
        make.height.mas_equalTo(10);
    }];
    
    [ self.tableView setupData:self.dataList index:3] ;
    [self.scrollerView addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.mas_bottom).with.offset(20);
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(MainScreenW);
//        make.height.mas_equalTo(WindowHeight-380-tabBarHeigh + 200);
//    }];
    self.scrollerView.contentSize = CGSizeMake(MainScreenW, WindowHeight-tabBarHeigh + 200);
}
- (void)setNavigationItem{
    leftbutton.hidden = YES ;

    UIButton *marketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [marketBtn addTarget:self action:@selector(marketClicked:) forControlEvents:UIControlEventTouchUpInside];
    [marketBtn setImage:Image(@"markets_") forState:UIControlStateNormal];
    [marketBtn setImage:Image(@"markets_hover") forState:UIControlStateSelected];
    [marketBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:marketBtn];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 40, 40);
    [collectBtn addTarget:self action:@selector(collectClicked:) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn setImage:Image(@"Collect_normal") forState:UIControlStateNormal];
    [collectBtn setImage:Image(@"Collect_highlight") forState:UIControlStateSelected];
    [collectBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
    
    UIButton *chooseCoinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseCoinBtn setTitle:@"BTC/KTC" forState:UIControlStateNormal];
    [chooseCoinBtn setImage:Image(@"drop-down") forState:UIControlStateNormal];
    [chooseCoinBtn setTitleColor:cblueLightColor forState:UIControlStateNormal];
    chooseCoinBtn.frame = CGRectMake(-20, 5, 100, 20);
    [chooseCoinBtn addTarget:self action:@selector(chooseCoinClicked:) forControlEvents:UIControlEventTouchUpInside];
    [chooseCoinBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];

    UIBarButtonItem *chooseCoinBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chooseCoinBtn];
    
    self.navigationItem.leftBarButtonItem  = chooseCoinBtnItem;
}


#pragma mark - action
- (void)marketClicked:(UIButton*)btn{
    btn.selected = !btn.selected ;
}
- (void)collectClicked:(UIButton*)btn{
    btn.selected = !btn.selected ;

}
- (void)chooseCoinClicked:(UIButton*)btn{
    
    TradingChooseCoinView *view = [[TradingChooseCoinView alloc] initWithFrame:self.view.frame];
    [view showView];
}
- (void)buyOrSellClicked:(UIButton*)btn{
    
    _foreBtn.selected = NO ;
    _foreBtn = btn ;
    _foreBtn.selected = YES ;
    
    UILabel *label = (UILabel *)[self.scrollerView viewWithTag:99];
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if (btn.tag==2) {
                make.left.equalTo(self.scrollerView.mas_left).with.offset(MainScreenW/2);
            } else {
                make.left.equalTo(self.scrollerView.mas_left).with.offset(15);
                
            };
            
        }];
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)allTradingClicked:(UIButton*)btn{
    TradingDetailViewController *vc = [[TradingDetailViewController alloc] init];
    [self pushViewController:vc];
}
#pragma mark - delegate/dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 ;
}
 -(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action == KPTradingCancelTableViewCell) {// 撤单
        
    }else{//详情
        
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = cBgColor ;
    
    UILabel*tradingTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, 80, 22)];
    tradingTimeLB.text = MyLocalized(@"Commissioned by the current");
    tradingTimeLB.textColor = cblueLightColor ;
    tradingTimeLB.font = sysFont(15);
    tradingTimeLB.textAlignment = NSTextAlignmentLeft ;
    [view addSubview:tradingTimeLB];
   
    UIButton*allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(0, 16, 80, 22);
    allBtn.right = MainScreenW ;
    [allBtn setTitle:MyLocalized(@"all") forState:UIControlStateNormal];
    [allBtn setTitleColor:cblueLightColor forState:UIControlStateNormal];
    [allBtn setImage:Image(@"page") forState:UIControlStateNormal];
    allBtn.titleLabel.font = sysFont(11) ;
    [allBtn addTarget:self action:@selector(allTradingClicked:) forControlEvents:UIControlEventTouchUpInside];
    [allBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    [view addSubview:allBtn];
    
    return view ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 ;
}
#pragma mark - setter/getter
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithObjects:@"12",@"21",@"21",@"12",@"21",@"21",@"12",@"21",@"21",@"12",@"21",@"21",@"12",@"21",@"21", nil];//
    }
    return _dataList ;
}
- (MTBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MTBaseTableView alloc] initWithFrame:CGRectMake(0, 380, MainScreenW, WindowHeight-380-tabBarHeigh + 100) tableviewStyle:UITableViewStylePlain];
        _tableView.attribute = self;
        _tableView.table.delegate = self ;
        
    }
    return _tableView ;
}
@end
