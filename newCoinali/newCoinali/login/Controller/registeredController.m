//
//  registeredController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/30.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "registeredController.h"
#import "loginController.h"
#import "RSACheck.h"

@interface registeredController ()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong)UITextField *passWordField;
@property (nonatomic ,strong)UITextField *accountField;
@property (nonatomic ,strong)UITextField *VerificationCodeField;
@end

@implementation registeredController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
    [self setNavigationBtn];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [ConfigManager stopNSTimer];
}

- (void)setNavigationBtn{
    [self setLeftButtonImage:Image(@"back") forState:UIControlStateNormal];
    
    rightbutton.hidden=NO;
    rightbutton.size=CGSizeMake(80, 22);
    [rightbutton setTitle:@"已有账户" forState:UIControlStateNormal];
    [rightbutton setTitleColor:cWhiteColor forState:UIControlStateNormal];
    rightbutton.titleLabel.font = sysFont(15);
}

- (void)home:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SetUI
- (void)setUI{
  
    SMLabel *nameLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(24)];
    nameLB.text = @"注册";
    nameLB.textAlignment = NSTextAlignmentLeft ;
    [self.view addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(25);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(80);
    }];
    
    NSString *message = @"中国用户主持手机或者邮箱注册\n其他国家用户只支持邮箱登录\n手机号和邮箱是唯一的地址,注册后无法修改";
    CGSize size = [message getSizeWithFont:sysFont(11) width:MainScreenW];
    
    SMLabel *messageLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cDarkBlueColor textFont:sysFont(11)];
    messageLB.text = message;
    messageLB.numberOfLines = 0 ;
    [self.view addSubview:messageLB];
    [messageLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLB.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(MainScreenW);
    }];
    
    
    NSArray *placeholderArr = @[@"手机号或者邮箱",@"验证码",@"密码"];
    for (int i = 0; i<placeholderArr.count; i++) {
        UITextField *accountField = [[UITextField alloc] init];
        accountField.placeholder = placeholderArr[i];
        accountField.textColor = cblueLightColor;
        accountField.font = sysFont(15);
        [accountField setValue:cDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        [accountField setValue:sysFont(15) forKeyPath:@"_placeholderLabel.font"];
       accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (i==0) {
            self.accountField = accountField ;
        }else if (i==1) {
            UIButton *rightVie = [UIButton buttonWithType:UIButtonTypeCustom];
            [rightVie setTitle:@"验证码发送" forState:UIControlStateNormal];
            rightVie.size = CGSizeMake(100, 30);
            rightVie.clipsToBounds = YES ;
            rightVie.layer.cornerRadius = 15 ;
            rightVie.layer.borderColor = [UIColor colorWithHexString:@"#3570CD"].CGColor ;
            rightVie.layer.borderWidth = 1 ;
            rightVie.contentMode = UIViewContentModeCenter;
            rightVie.titleLabel.font = sysFont(11);
            accountField.rightView = rightVie;
            accountField.rightViewMode = UITextFieldViewModeAlways;
            [rightVie addTarget:self action:@selector(countdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:accountField];
            self.VerificationCodeField = accountField ;

        }else{
            accountField.secureTextEntry = YES ;
            self.passWordField = accountField ;

        }
        [self.view addSubview:accountField];
        [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(messageLB.mas_bottom).with.offset(40 + i*60);
            make.left.equalTo(self.view.mas_left).with.offset(25);
            make.width.mas_equalTo(MainScreenW-50);
            make.height.mas_equalTo(60);
            
        }];
        UILabel *linLB = [UILabel new];
        linLB.backgroundColor = clinecolor;
        [self.view addSubview:linLB];
        [linLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(accountField.mas_bottom);
            make.left.equalTo(self.view.mas_left).with.offset(15);
            make.width.mas_equalTo(MainScreenW-30);
            make.height.mas_equalTo(1);
        }];
    };

    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [registerBtn addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordField.mas_bottom).with.offset(50);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(MainScreenW-30);
        make.height.mas_equalTo(46);
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer]; gradientLayer.frame = CGRectMake(0, 0, MainScreenW-30, 60);
    // 创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithHexString:@"#3C73C9"].CGColor,
                            (id)[UIColor colorWithHexString:@"#5284D2"].CGColor,
                            nil];
    // 设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0); gradientLayer.endPoint = CGPointMake(1, 1);
    // 设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    [registerBtn.layer addSublayer:gradientLayer];
    
    [registerBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [registerBtn setTitleColor:cWhiteColor forState:UIControlStateNormal];
    registerBtn.clipsToBounds = YES ;
    registerBtn.layer.cornerRadius = 23 ;
    registerBtn.titleLabel.font = sysFont(15);
}

#pragma mark - Action
- (void)countdownClicked:(UIButton*)btn{
    if ([IHUtility Trim:self.accountField.text].length<=0 ) {
        [self addSucessView:MyLocalized(@"Please complete the information") type:1];
        return;
    }
    BOOL rightPhoneNumber = [IHUtility checkPhoneValidate:[IHUtility Trim:self.accountField.text]];
    BOOL rightEmail = [IHUtility validateEmail:[IHUtility Trim:self.accountField.text]];
     if (rightPhoneNumber) {
         [network getVerificationCodeWith:[IHUtility Trim:self.accountField.text] success:^(NSDictionary *obj) {
             [self addSucessView:MyLocalized(@"The verification code was sent successfully") type:1];
             [self countdown:btn];
         } failure:^(NSDictionary *obj2) {
             [self addSucessView:MyLocalized(@"The verification code was sent failure") type:1];

         }];
         
     }else if (rightEmail){
         [network getVerificationCodeWithEmailAddress:[IHUtility Trim:self.accountField.text] success:^(NSDictionary *obj) {
             [self addSucessView:MyLocalized(@"The verification code was sent successfully") type:1];
             [self countdown:btn];
         } failure:^(NSDictionary *obj2) {
             [self addSucessView:MyLocalized(@"The verification code was sent failure") type:1];

         }];
     }
     else{
        [self addSucessView:MyLocalized(@"Please enter the correct phone number or email address") type:1];
    }
    
   
}

- (void)registerClicked:(UIButton*)btn{
//    [IHUtility Trim:self.accountField.text];
//    [IHUtility Trim:self.passWordField.text];
    

    BOOL rightPhoneNumber = [IHUtility checkPhoneValidate:[IHUtility Trim:self.accountField.text]];
      BOOL rightEmail = [IHUtility validateEmail:[IHUtility Trim:self.accountField.text]];
    
    if ([IHUtility Trim:self.accountField.text].length<=0 || [IHUtility Trim:self.passWordField.text].length<=0 ||[IHUtility Trim:self.VerificationCodeField.text].length<=0) {
        [self addSucessView:MyLocalized(@"Please complete the information") type:1];
        return;
    }
    if (rightEmail || rightPhoneNumber) {
        [self.view endEditing:YES];
          NSString *securePwd = [RSACheck encryptString:[IHUtility Trim:self.passWordField.text] publicKey:KP_PublicKey];//
        if (rightPhoneNumber) {
        
            [network getRegisteredWith:[IHUtility Trim:self.accountField.text] password:securePwd email:@"" nickName:@"" mgsCode:[IHUtility Trim:self.VerificationCodeField.text] inviteId:@"" inviteCode:@"" type:@"phoneNumber" success:^(NSDictionary *obj) {
                [IHUtility addSucessView:MyLocalized(@"Registered successfully") type:1];
                [self popViewController:YES];
            } failure:^(NSDictionary *obj2) {

            }];
            
        } else {
            [network getRegisteredWith:@"" password:securePwd email:[IHUtility Trim:self.accountField.text] nickName:@"" mgsCode:[IHUtility Trim:self.VerificationCodeField.text] inviteId:@"" inviteCode:@"" type:@"email" success:^(NSDictionary *obj) {
                [IHUtility addSucessView:MyLocalized(@"Registered successfully") type:1];
                [self popViewController:YES];

            } failure:^(NSDictionary *obj2) {
            }];
        }
    }else{
        [self addSucessView:MyLocalized(@"Please enter the correct phone number or email address") type:1];
    }
}
#pragma mark - NetworkingData

#pragma mark - Delegate
#pragma mark - Customer Method
- (void)countdown:(UIButton*)btn
{
    [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
     {
         NSLog(@"---%ld",(long)ConfigManager.seconds);
         if (ConfigManager.seconds>0) {
             
             [btn setTitle:[NSString stringWithFormat:@"（%@s）",title] forState:UIControlStateNormal];;
         }else
         {
             [btn setTitle:@"验证码发送" forState:UIControlStateNormal];
             
         }
         
     }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - Setter/getter


@end
