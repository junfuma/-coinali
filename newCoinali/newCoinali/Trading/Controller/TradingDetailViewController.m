//
//  TradingDetailViewController.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/10.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "TradingDetailViewController.h"

@interface TradingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong)MTBaseTableView  *  tableView  ;
@property  (nonatomic,strong)NSMutableArray  *   dataList;
@end

@implementation TradingDetailViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    leftbutton.hidden = NO ;
    [self setLeftButtonImage:Image(@"back") forState:UIControlStateNormal];

    [self SetUI];
    [self setNaviagation];

}
#pragma mark - SetUI
- (void)SetUI{
    [ self.tableView setupData:self.dataList index:3] ;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.view);
        make.bottom .mas_equalTo(WindowHeight);
    }];
    
}
- (void)setNaviagation{
    UIButton *chooseCoinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseCoinBtn setImage:Image(@"history") forState:UIControlStateNormal];
    chooseCoinBtn.frame  = CGRectMake(0, 0, 40, 40);
    [chooseCoinBtn addTarget:self action:@selector(historyTradingClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *chooseCoinBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chooseCoinBtn];
    
    self.navigationItem.rightBarButtonItem  = chooseCoinBtnItem;
}
#pragma mark - Action
- (void)allTradingClicked:(UIButton*)btn{
   
}
- (void)historyTradingClicked:(UIButton*)btn{
    
}

#pragma mark - NetworkingData
#pragma mark - Delegate
#pragma mark - Customer Method
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
//    history
    UIButton*allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(0, 16, 80, 22);
    allBtn.right = MainScreenW ;
    [allBtn setTitle:MyLocalized(@"screening") forState:UIControlStateNormal];
    [allBtn setTitleColor:cblueLightColor forState:UIControlStateNormal];
    [allBtn setImage:Image(@"choose") forState:UIControlStateNormal];
    allBtn.titleLabel.font = sysFont(15) ;
    [allBtn addTarget:self action:@selector(allTradingClicked:) forControlEvents:UIControlEventTouchUpInside];
    [allBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    [view addSubview:allBtn];
    
    return view ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 ;
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
        _tableView = [[MTBaseTableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, WindowHeight) tableviewStyle:UITableViewStylePlain];
        _tableView.attribute = self;
        _tableView.table.delegate = self ;
        
    }
    return _tableView ;
}

@end
