//
//  loginController.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "loginController.h"
#import "registeredController.h"
#import "HomePageController.h"
@interface loginController ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong)UITextField *passWordField;
@property (nonatomic ,strong)UITextField *accountField;

@end

@implementation loginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self setNavigationBtn];
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden)
                                                 name:UIKeyboardDidHideNotification object:nil];
}
- (void)setUI{
    SMLabel *titleLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cblueLightColor textFont:sysFont(24)];
    titleLB.text = @"登录";
    [self.view addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(31);
    }];
    
    UIImageView *loginImageView = [[UIImageView alloc] initWithImage:Image(@"logo white")];
    [self.view addSubview:loginImageView];
    [loginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLB.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(34);
    }];

    
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = MyLocalized(@"Please enter a user name");
    nameField.textColor = cblueLightColor;
    [nameField setValue:cDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
    [nameField setValue:sysFont(15) forKeyPath:@"_placeholderLabel.font"];
    nameField.font = sysFont(15);
    self.accountField = nameField ;
    [self.view addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(200);
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.width.mas_equalTo(MainScreenW-50);
        make.height.mas_equalTo(30);
        
    }];
    
    UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightView setImage:Image(MyLocalized(@"close")) forState:UIControlStateNormal];;
    rightView.size = CGSizeMake(40, 40);
    rightView.contentMode = UIViewContentModeCenter;
    [rightView addActionHandler:^(NSInteger tag) {
        nameField.text = @"";
    }];
    nameField.rightView = rightView;
    nameField.rightViewMode = UITextFieldViewModeAlways;
  
    UILabel *lineLB = [UILabel new];
    lineLB.backgroundColor = [UIColor colorWithHexString:@"#04204C"];
    [self.view addSubview:lineLB];
    [lineLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameField.mas_bottom);
        make.left.equalTo(nameField.mas_left);
        make.width.mas_equalTo(MainScreenW-30);
        make.height.mas_equalTo(1);
    }];
    
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.placeholder = MyLocalized(@"Please enter password");
    pwdField.textColor = cblueLightColor;
    pwdField.secureTextEntry = YES;
    pwdField.font = sysFont(15);
    [pwdField setValue:cDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
    [pwdField setValue:sysFont(15) forKeyPath:@"_placeholderLabel.font"];
    
    UIButton *rightVie = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightVie setImage:Image(MyLocalized(@"preview")) forState:UIControlStateNormal];
    rightVie.size = CGSizeMake(40, 40);
    rightVie.contentMode = UIViewContentModeCenter;
    [rightVie addActionHandler:^(NSInteger tag) {
        pwdField.secureTextEntry = !pwdField.secureTextEntry;
    }];
    pwdField.rightView = rightVie;
    pwdField.rightViewMode = UITextFieldViewModeAlways;
    self.passWordField = pwdField;
    [self.view addSubview:pwdField];
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameField.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.width.mas_equalTo(MainScreenW-50);
        make.height.mas_equalTo(30);
        
    }];
    UILabel *linLB = [UILabel new];
    linLB.backgroundColor = [UIColor colorWithHexString:@"#04204C"];
    [self.view addSubview:linLB];
    [linLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdField.mas_bottom);
        make.left.equalTo(pwdField.mas_left);
        make.width.mas_equalTo(MainScreenW-30);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
 
    [loginBtn addActionHandler:^(NSInteger tag) {
       
        
        
    }];
    [loginBtn addTarget:self action:@selector(loaginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdField.mas_bottom).with.offset(50);
        make.left.mas_equalTo(25);
        make.width.mas_equalTo(MainScreenW-50);
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
    [loginBtn.layer addSublayer:gradientLayer];
   
    [loginBtn setTitle:MyLocalized(@"login") forState:UIControlStateNormal];
    [loginBtn setTitleColor:cWhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = sysFont(15);
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = 23;
    
    NSArray *titleArr = @[MyLocalized(@"Email login"),MyLocalized(@"Forgot password")];
    for (int i = 0; i<2; i++) {
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [Btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:cblueLightColor forState:UIControlStateNormal];
        Btn.titleLabel.font = sysFont(15);
        Btn.tag = 10+i;
        [Btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:Btn];
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).with.offset(20);
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
            if (i==0) {
                make.left.mas_equalTo(25);
                Btn.hidden = YES ;
            } else {
                make.right.equalTo(self.view.mas_right).with.offset(-25);
            }
        }];
        
    };
}
- (void)setNavigationBtn{
    [self setLeftButtonImage:Image(@"back") forState:UIControlStateNormal];
    
    rightbutton.hidden=NO;
    rightbutton.size=CGSizeMake(80, 20);
    [rightbutton setTitle:MyLocalized(@"Register a new account") forState:UIControlStateNormal];
    [rightbutton setTitleColor:cblueLightColor forState:UIControlStateNormal];
    rightbutton.titleLabel.font = sysFont(15);
}
#pragma mark - action Response
- (void)home:(id)sender{
    registeredController *VC = [[registeredController alloc] init];
    [self pushViewController:VC];
}
- (void)btnClicked:(UIButton*)btn{
    if (btn.tag == 10) {//邮箱登录
        
    } else {//忘记密码
        
    }
}
- (void)loaginClicked:(UIButton*)btn{
    //        去除首尾空格
    [self.view endEditing:YES];
    
    NSString* account =   [IHUtility Trim:self.accountField.text];
    if (account.length<=0) {
        [self addSucessView:MyLocalized(@"Please enter the correct account name") type:1];
        return;
    }
    NSString* pwd = [RSAEncryptor encryptString:[IHUtility Trim:self.passWordField.text] publicKey:KP_PublicKey ];
    
    BOOL rightPhoneNumber = [IHUtility checkPhoneValidate:[IHUtility Trim:self.accountField.text]];
    BOOL rightEmail = [IHUtility validateEmail:[IHUtility Trim:self.accountField.text]];
    NSString *loginType ;
    if (rightPhoneNumber) {
        loginType = @"mobile";
    } else if(rightEmail){
        loginType = @"email";

    }else{
        [self addSucessView:MyLocalized(@"Please enter the correct account name") type:1];
        return;
    }
    
    [network getLoginWithMobile:account password:pwd loginType:loginType success:^(NSDictionary *obj) {
//        NSDictionary *userDic =obj[@"result"][@"data"];
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"46",@"userId", nil];
        [USERMODEL setUserInfo:userDic];
        [self addSucessView:MyLocalized(@"Log in successfully") type:1];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil];

    } failure:^(NSDictionary *obj2) {
        
    }];
    
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
    
}

#pragma mark 实现监听到键盘变化时的触发的方法
// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification
{
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSLog(@"%@",keyboardObject);
    
    //得到键盘的高度
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"%f",duration);
    //调整放置有textView的view的位置
    
    float height = MainScreenH - keyboardRect.size.height - self.passWordField.bottom;
    if (height>0) return;

    //设置view的frame，往上平移
    [UIView animateWithDuration:duration animations:^{
        [self.accountField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(fabsf (height));
        }];
        [self.passWordField updateConstraints];
    }];

    
}

//键盘消失时
-(void)keyboardDidHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.accountField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(200);
        }];
        [self.passWordField updateConstraints];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

