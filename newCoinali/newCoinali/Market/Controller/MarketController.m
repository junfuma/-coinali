//
//  MarketController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "MarketController.h"
#import "sortingCoinView.h"
#import "chooseCoinView.h"
@interface MarketController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong)MTBaseTableView *tableView ;/**< tableView */
@property (nonatomic , strong)NSMutableArray *datalist ;/**< 数据源 */
@property (nonatomic , strong)NSMutableArray *coinlist ;/**< 顶部货币数组 */
@property (nonatomic , strong)UIScrollView *BaseScrollView ;
@property (nonatomic , strong)chooseCoinView *coninView ;

@end

@implementation MarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self setNavigationItem];
}


#pragma mark - set up UI
- (void)setUI{
    
    self.coninView = [[chooseCoinView alloc] initWithFrame:CGRectZero btnArr:self.coinlist];
    [self.view addSubview:self.coninView];
    [self.coninView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(MainScreenW);
        make.height.mas_equalTo(40);

    }];
    @weakify(self);
    self.coninView.didClickedBlock = ^(NSInteger index) {
        @strongify(self);
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.BaseScrollView.contentOffset = CGPointMake(MainScreenW*(index-10), 1);
            
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.BaseScrollView.mas_left).with.offset(MainScreenW*(index-10));
                
            }];
            
        } completion:^(BOOL finished) {
            
        }];
    };
    [self.view addSubview:self.BaseScrollView];
    
    self.datalist = @[@"2121",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212",@"212"];
    [ self.tableView setupData:self.datalist index:2] ;
//    self.tableView.frame = CGRectMake(0, 40, MainScreenW, WindowHeight-40-tabBarHeigh);
    [self.BaseScrollView addSubview:self.tableView];
//   mas_updateConstraints
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self.view);
//        make.top.equalTo(coninView.mas_bottom);
//        make.height.mas_equalTo(WindowHeight-40-tabBarHeigh);
//    }];
       self.BaseScrollView .contentSize = CGSizeMake(MainScreenW * self.coinlist.count, WindowHeight-40-tabBarHeigh);
}
- (void)setNavigationItem{
    rightbutton.hidden = NO ;
    rightbutton.size = CGSizeMake(18, 18);
    [rightbutton setImage:[UIImage imageWithOriginalNamed:@"Seach_normal"] forState:UIControlStateNormal];
}

#pragma mark - netWork data
#pragma mark - action
- (void)home:(id)sender
{
    
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    
}
#pragma mark - uitableviewDatasource/delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38 ;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blackColor] ;
    
    sortingCoinView *sortView = [[sortingCoinView alloc] initWithFrame:CGRectZero btnArr:@[MyLocalized(@"currency"),MyLocalized(@"The latest price"),MyLocalized(@"24 H Rise and fall")]];
    [view addSubview:sortView];
    [sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(view);
    }];
    sortView.didClickedBlock = ^(NSInteger index) {
        switch (index) {
            case 10:
                
                break;
            case 11:
                
                break;
            case 12:
                
                break;
            default:
                break;
        }
    };
    return view ;
}
#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint point=scrollView.contentOffset;
//
//    CGFloat ind = point.x/MainScreenW;
//    NSLog(@"%f",ind);
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.BaseScrollView.mas_left).with.offset(point.x);
//
//    }];
    
}
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidEndDecelerating");
    CGPoint point=scrollView.contentOffset;

    [scrollView setContentOffset:CGPointMake(point.x, 1) animated:YES];
    
}

// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidEndScrollingAnimation");
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f",point.x);

    if (point.x >=MainScreenW/1.0) {
        CGFloat ind = point.x/MainScreenW;
        NSLog(@"%f",ind);
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            if (point.x >=MainScreenW*4.0) {
                
                self.coninView.scroller.contentOffset = CGPointMake(75+(point.x/MainScreenW/1.0-4.0)*95, 0);
                [self.coninView.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self.coninView.mas_left).with.offset(MainScreenW-35);
                }];
            }else{
                self.coninView.scroller.contentOffset = CGPointMake(0, 0);
                [self.coninView.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self.coninView.mas_left).with.offset(point.x/MainScreenW*(31+63)+37.5);
                }];
            }
            
            
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.BaseScrollView.mas_left).with.offset(point.x);
                
            }];
           
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (point.x<=0.0) {
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.coninView.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.coninView.mas_left).with.offset(35);
            }];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.BaseScrollView.mas_left).with.offset(point.x);
                
            }];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.BaseScrollView.mas_left).with.offset(0);
                
            }];
        } completion:^(BOOL finished) {
            
        }];
    }
    
}


#pragma mark - setter/getter
- (MTBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MTBaseTableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, WindowHeight-40-tabBarHeigh) tableviewStyle:UITableViewStylePlain];
        _tableView.attribute = self ;
        _tableView.table.delegate=self ;
        _tableView.backgroundColor = cBgColor ;
       
    }
    return _tableView ;
}
- (UIScrollView *)BaseScrollView
{
    if (!_BaseScrollView) {
        _BaseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, MainScreenW, WindowHeight-40-tabBarHeigh)];
        _BaseScrollView.delegate = self;
        _BaseScrollView.pagingEnabled = YES ;
        _BaseScrollView.directionalLockEnabled = YES;
    }
    return _BaseScrollView ;
}
- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
        
    }
    return _datalist ;
}
- (NSMutableArray *)coinlist
{
    if (!_coinlist) {
        _coinlist = [NSMutableArray arrayWithObjects:MyLocalized(@"optional"),MyLocalized(@"ETC"),MyLocalized(@"BTC"),MyLocalized(@"HKT"),MyLocalized(@"ETC"),MyLocalized(@"BTC"),MyLocalized(@"HKT"), nil];
    }
    return _coinlist ;
}
@end
