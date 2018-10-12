//
//  HomePageController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "HomePageController.h"
#import "SDCycleScrollView.h"
#import "advertisingView.h"
#import "accountMessageView.h"
#import "loginController.h"
#import "FallOrRoseVIew.h"



@interface HomePageController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)advertisingView *adView;
@property (nonatomic , strong)accountMessageView*accountView;



@property (nonatomic , strong)NSMutableArray *adImageArray ;/**< 广告数组 */
@property (nonatomic , strong)NSMutableArray *adTitleArr ;/**< 消息数组 */
@property (nonatomic , strong)UIScrollView *BaseScrollerView ;
@property  (nonatomic,strong)MTBaseTableView  *  tableView  ;
@property  (nonatomic,strong)NSMutableArray  *      fallDataList;//跌
@property  (nonatomic,strong)NSMutableArray  *      roseDataList;//涨

@end

@implementation HomePageController

#pragma mark - life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES] ;
        [self initAcountView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationView];
    [self initAdvertirseView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginInNotification:) name:NotificationLoginIn object:nil];
}
#pragma mark - setUI
- (void)initNavigationView{
    UIButton *chooseCoinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseCoinBtn.frame = CGRectMake(0, 5, 100, 24);
    UIImageView* bb=[[UIImageView alloc]initWithImage:Image(@"logo white")];
    CGRect tRect3 = CGRectMake(0,0, 100, 24);
    bb.frame=tRect3;
    [chooseCoinBtn addSubview:bb] ;
    chooseCoinBtn.userInteractionEnabled = NO ;
    UIBarButtonItem *chooseCoinBtnItem = [[UIBarButtonItem alloc] initWithCustomView:chooseCoinBtn];
    
    self.navigationItem.leftBarButtonItem  = chooseCoinBtnItem;
}
- (void)initAdvertirseView{
    UIScrollView *scrollerView = [[UIScrollView alloc] init];
    scrollerView.backgroundColor = cBgColor;
    scrollerView.scrollEnabled = YES;
    scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollerView];
    self.BaseScrollerView = scrollerView;
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.view);
    }];
    
    self.adView = [[advertisingView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, (208.0-74.0)/345.0*MainScreenW) imageArray:self.adImageArray titleArray:self.adTitleArr];
    self.adView.userInteractionEnabled = YES;
    self.adView.clipsToBounds = YES ;
    self.adView.layer.cornerRadius = 15 ;
    [scrollerView addSubview:self.adView];
    self.adView.selectBlock = ^(advertisingType type) {
        if (type == KP_HpomePageAD) {
            
        } else {
            
        }
    };
    
//    scrollerView.contentSize = CGSizeMake(MainScreenW, cycleScrollView4.bottom+10);
}
- (void)initAcountView {
    personPropertyMessageType type ;
    if ([IHUtility getUserDefalutDic:kUserDefalutLoginInfo]) {
        type = KP_personPropertyHomePageLogin ;
    } else {
        type = KP_personPropertyHomePageNo;
    }
    accountMessageView *view = [[accountMessageView alloc] initWithFrame:CGRectZero type:type];
    [self.BaseScrollerView addSubview:view];
    self.accountView = view ;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.adView.mas_bottom).with.offset(30);
        make.left.equalTo(self.BaseScrollerView.mas_left).with.offset(15);
        make.width.mas_equalTo(MainScreenW-30);
        make.height.mas_equalTo(100);
    }];
    view.selectBlock = ^(NSInteger index) {
        loginController *vc = [[loginController alloc] init];
        [self pushViewController:vc];
        /**
         UIApplication *application = [UIApplication sharedApplication];
         application.keyWindow.rootViewController = nil;
         
         loginController *loginVC = [[loginController alloc] init];
         
         UINavigationController *mainVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
         application.keyWindow.rootViewController = mainVC;
         
         */
        
    };

    NSArray *titleArr = @[MyLocalized(@"Currency's community"),MyLocalized(@"OTC trading"),MyLocalized(@"Invite commission"),MyLocalized(@"Help center")];
    NSArray *imageArr = @[MyLocalized(@"Community"),MyLocalized(@"deal"),MyLocalized(@"commission"),MyLocalized(@"help")];

    CGFloat tableTop ;

    CGFloat BtnW = MainScreenW/4 ;
    for (int i = 0; i<4; i++) {
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:cLightWhiteColor forState:UIControlStateNormal];
        [Btn setImage:Image(imageArr[i]) forState:UIControlStateNormal];
        Btn.tag = 10+i;
        Btn.titleLabel.font = sysFont(11) ;
        [Btn addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];

        [self.BaseScrollerView addSubview:Btn];
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).with.offset(10);
            make.left.equalTo(self.view.mas_left).with.offset(BtnW *i);
            make.width.mas_equalTo(BtnW);
            make.height.mas_equalTo(70);
        }];
        [Btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        tableTop = view.top + 100 + 70 + 35  ;
    };
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor blackColor];
    [self.BaseScrollerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).with.offset(90);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(MainScreenW);
        make.height.mas_equalTo(10);
    }];
    
    FallOrRoseVIew *fallRoseView = [[FallOrRoseVIew alloc] initWithFrame:CGRectZero btnArr:@[MyLocalized(@"performer"),MyLocalized(@"Drop list")]];
    [self.BaseScrollerView addSubview:fallRoseView];
    @weakify(self);
    fallRoseView.selectBlock = ^(NSInteger index) {
        @strongify(self);
        if (index==10) {
//            涨
            self.tableView.Type = KP_homepageRose ;
            [self.tableView setupData:self.roseDataList index:1] ;
            [self.tableView.table reloadData];

        } else {
//            跌
            self.tableView.Type = KP_homepageFall ;
            [ self.tableView setupData:self.fallDataList index:1] ;
            [self.tableView.table reloadData];

        }
    };
    [fallRoseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (lineView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(MainScreenW);
        make.height.mas_equalTo(43);
    }];
    
    self.tableView = [[MTBaseTableView alloc] initWithFrame:CGRectMake(0, (208.0-74.0)/345.0*MainScreenW +130 +145, MainScreenW, (WindowHeight- (208.0-74.0)/345.0*MainScreenW +130 +145)-tabBarHeigh -420) tableviewStyle:UITableViewStylePlain] ;
    self.tableView.attribute = self ;
    self.tableView.table.delegate=self ;
    self.roseDataList = @[@"第一个",@"第一个",@"第一个",@"第一个"];
    self.fallDataList = @[@"第一个",@"第一个",@"第一个"];
    self.tableView.Type = KP_homepageRose ;
    [ self.tableView setupData:self.roseDataList index:1] ;
    [self.BaseScrollerView addSubview: self.tableView] ;
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(fallRoseView.mas_bottom).with.offset(1);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.width.mas_equalTo(MainScreenW);
//        make.height.mas_equalTo(600);
//    }];
    self.BaseScrollerView.contentSize = CGSizeMake(MainScreenW, WindowHeight-tabBarHeigh +200);
}
#pragma mark - action Respones
- (void)chooseCategory:(UIButton*)btn{
    NSLog(@"%ld",(long)btn.tag);
    switch (btn.tag) {
        case 10:
            
            break;
        case 11:
            
            break;
        case 12:
            
            break;
        case 13:
            
            break;
            
        default:
            break;
    }
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    
}
-(void)loginInNotification:(NSNotification *)notification{
    
}
#pragma  mark  -  UITableViewDataSource
-  (CGFloat)tableView:(UITableView  *)tableView  heightForRowAtIndexPath:(NSIndexPath  *)indexPath
{
    return  55;
}

#pragma mark - setter/getter
- (NSMutableArray *)adImageArray{
    if (!_adImageArray) {
        _adImageArray = [NSMutableArray arrayWithObjects:@"http://e.hiphotos.baidu.com/image/pic/item/9358d109b3de9c82ddf742856181800a19d8432d.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539566995&di=1faaf3c91319edbd34553de4dd15997d&imgtype=jpg&er=1&src=http%3A%2F%2Fi3.lis99.com%2Fupload%2Fclub%2F2017%2F02%2F12%2F1486887965_fHzkfz9q.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538972278533&di=7b5882c10ae6ab67211431093eae9265&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3Da7486bebddca7bcb6976cf6cd6600116%2F0b46f21fbe096b6323620c7806338744ebf8ac9b.jpg", nil];
    }
    return _adImageArray ;
}
- (NSMutableArray *)adTitleArr{
    if (!_adTitleArr) {
        _adTitleArr = [NSMutableArray arrayWithObjects:@"新建交流QQ群：185534916 ",
                       @"📚disableScrollGesture可以设置禁止拖动",
                       @"🆕感谢您的支持，如果下载的",
                       @"如果代码在使用过程中出现问题",
                       @"您可以发邮件到gsdios@126.com", nil];
    }
    return _adTitleArr;
}
- (NSMutableArray *)roseDataList{
    if (!_roseDataList) {
        _roseDataList = [NSMutableArray array];
    }
    return _roseDataList ;
}
- (NSMutableArray *)fallDataList{
    if (!_fallDataList) {
        _fallDataList = [NSMutableArray array];
    }
    return _fallDataList ;
}
@end
