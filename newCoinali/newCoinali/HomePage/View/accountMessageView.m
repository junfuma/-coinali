//
//  accountMessageView.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/30.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "accountMessageView.h"

@implementation accountMessageView

- (id)initWithFrame:(CGRect)frame type:(personPropertyMessageType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(1, 22, 65);
        
        UIImageView *imageView = [UIImageView new];
        
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 15 ;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.height.equalTo(self);
        }];
        if (type == KP_personPropertyHomePageLogin) {
            
            imageView.image = Image(MyLocalized(@"My assets - post-login background"));
            
            SMLabel *accountNameLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(11)];
            accountNameLB.text = @"交易账户";
            [self addSubview:accountNameLB];
            [accountNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(10);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.equalTo(self.mas_width);
                make.height.mas_equalTo(18);

            }];
            
            SMLabel *BTCLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cWhiteColor textFont:sysFont(15)];
            BTCLB.text = @"0.00000  BTC";
            [self addSubview:BTCLB];
            [BTCLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(accountNameLB.mas_bottom).with.offset(5);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.equalTo(self.mas_width);
                make.height.mas_equalTo(22);
                
            }];
            
            SMLabel *USDLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(11)];
            USDLB.text = @"$ 0.0000   USD";
            [self addSubview:USDLB];
            [USDLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(BTCLB.mas_bottom).with.offset(10);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.equalTo(self.mas_width);
                make.height.mas_equalTo(18);
                
            }];
            
        } else if(type == KP_personPropertyHomePageNo) {
            
            
            imageView.image = Image(MyLocalized(@"My assets - pre-login background"));

            SMLabel *accountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cWhiteColor textFont:sysFont(15)];
            accountLB.text = @"我的资产";
            [self addSubview:accountLB];
            [accountLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(-12);
                make.left.equalTo(self.mas_left).with.offset(20);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(22);
                
            }];
            
            SMLabel *tipLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(11)];
            tipLB.text = @"登陆后可查看";
            [self addSubview:tipLB];
            [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(10);
                make.left.equalTo(self.mas_left).with.offset(20);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(17);
                
            }];
            
            UIButton *loginBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            loginBtn.backgroundColor = cBgColor;
            [loginBtn setTitleColor:[UIColor colorWithRed:78/255.0 green:122/255.0 blue:191/255.0 alpha:1/1.0] forState:UIControlStateNormal];
            loginBtn.clipsToBounds = YES;
            loginBtn.layer.borderColor = [UIColor colorWithHexString:@"#3570CD"].CGColor ;
            loginBtn.layer.borderWidth = 1 ;
            loginBtn.layer.cornerRadius = 15 ;
            loginBtn.titleLabel.font = sysFont(11);
            [loginBtn addActionHandler:^(NSInteger tag) {
                self.selectBlock(0);
            }];
            [self addSubview:loginBtn];
            [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(self.mas_right).with.offset(-15);
                make.width.mas_equalTo(70);
                make.height.mas_equalTo(30);
                
            }];
        }else if (type == KP_personPropertyMineLogin){
            imageView.image = Image(MyLocalized(@"My assets - post-login background"));

            
            SMLabel *accountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cWhiteColor textFont:sysFont(20)];
            accountLB.text = @"131****1514";
            [self addSubview:accountLB];
            [accountLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(-15);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(27);
                
            }];
            
            SMLabel *tipLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(14)];
            tipLB.text = @"UDID:1234567890";
            [self addSubview:tipLB];
            [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(11);
                make.left.equalTo(self.mas_left).with.offset(20);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(21);
                
            }];
        }else{
            imageView.image = Image(MyLocalized(@"My assets - pre-login background"));
            
            SMLabel *accountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cWhiteColor textFont:sysFont(20)];
            accountLB.text = @"登陆查看";
            [self addSubview:accountLB];
            [accountLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(-15);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(27);
                
            }];
            
            SMLabel *tipLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(14)];
            tipLB.text = @"欢迎使用coninali";
            [self addSubview:tipLB];
            [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(10);
                make.left.equalTo(self.mas_left).with.offset(15);
                make.width.mas_equalTo(150);
                make.height.mas_equalTo(21);
                
            }];
            
            UIButton *loginBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            loginBtn.backgroundColor = cBgColor;
            [loginBtn setTitleColor:[UIColor colorWithRed:78/255.0 green:122/255.0 blue:191/255.0 alpha:1/1.0] forState:UIControlStateNormal];
            loginBtn.clipsToBounds = YES;
            loginBtn.layer.borderColor = [UIColor colorWithHexString:@"#3570CD"].CGColor ;
            loginBtn.layer.borderWidth = 1 ;
            loginBtn.layer.cornerRadius = 15 ;
            loginBtn.titleLabel.font = sysFont(11);
            [loginBtn addActionHandler:^(NSInteger tag) {
                self.selectBlock(0);
            }];
            [self addSubview:loginBtn];
            [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(self.mas_right).with.offset(-15);
                make.width.mas_equalTo(70);
                make.height.mas_equalTo(30);
                
            }];
        }
        
    }
    return self;
}

@end
