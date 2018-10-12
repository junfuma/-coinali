//
//  MineController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "MineController.h"
#import "accountMessageView.h"
#import "loginController.h"
@interface MineController ()<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong)NSMutableArray  *      DataList;
@property  (nonatomic,strong)NSMutableArray  *      imageArr;

@property  (nonatomic,strong)UITableView  *      tableView;

@end

@implementation MineController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUPUI];
}
#pragma mark - setupUI
- (void)setUPUI{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(self.view);
        
    }];
}
#pragma mark - uitableviewDataSource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataList.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *settingCell = @"MIneCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCell];
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = cBgColor ;
    cell.accessoryType = UITableViewCellStyleDefault;
    cell.textLabel.text =  self.DataList[indexPath.row];
    cell.textLabel.textColor = cblueLightColor ;
    cell.textLabel.font = sysFont(15);
    //1、首先对image付值
    
    [cell.imageView setImage:Image(self.imageArr[indexPath.row])];
    
    //2、调整大小
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:Image(@"more")];
    [cell.contentView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView.centerY);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(18);

    }];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView  = [[UIView alloc] init];
    headerView.backgroundColor = cBgColor ;
    
    personPropertyMessageType type ;
    if ([IHUtility getUserDefalutDic:kUserDefalutLoginInfo]) {
        type = KP_personPropertyMineLogin ;
    } else {
        type = KP_personPropertyMineNo;
    }
    accountMessageView *view = [[accountMessageView alloc] initWithFrame:CGRectMake(15, 10, MainScreenW-30, 80) type:type];
    [headerView addSubview:view];
    
    view.selectBlock = ^(NSInteger index) {
        loginController *vc = [[loginController alloc] init];
        [self pushViewController:vc];
        
    };
    return headerView ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - setter/getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self ;
        _tableView.dataSource = self;
        _tableView.backgroundColor = cBgColor ;
         _tableView.separatorColor = clinecolor;
    }
    return _tableView ;
}
- (NSMutableArray *)DataList
{
    if (!_DataList) {
        _DataList = [NSMutableArray arrayWithObjects:MyLocalized(@"My assets"),MyLocalized(@"The identity authentication"),MyLocalized(@"Security center"),MyLocalized(@"Transaction management"),MyLocalized(@"Invite commission"),MyLocalized(@"Help center"),MyLocalized(@"System Settings"),MyLocalized(@"About us"), nil];
    }
    return _DataList ;
}
- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray arrayWithObjects:@"porkey",@"VERB",@"safe",@"order",@"invite",@"help",@"setting",@"about", nil];
    }
    return _imageArr ;
}
@end















