//
//  BuyOrSellView.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/10.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "BuyOrSellView.h"
@interface BuyOrSellView ()<UIGestureRecognizerDelegate>


@property (nonatomic , strong)UILabel *count ;
@property (nonatomic , strong)UILabel *currentSliderValueLB ;


@end
@implementation BuyOrSellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *addreduceImage = [[UIImageView alloc] initWithImage:Image(@"reduceOrAdd_image")];
        [addreduceImage sizeToFit];
        [self addSubview:addreduceImage];
        [addreduceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(MainScreenW/2-15);
            make.height.mas_equalTo(30);
        }];
        
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reduceBtn setImage:Image(@"reduce_image") forState:UIControlStateNormal];
        [reduceBtn addTarget:self action:@selector(reduceCoinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [addreduceImage addSubview:reduceBtn];
        [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1) ;
            make.left.mas_equalTo(1);
            make.width.mas_equalTo(29);
            make.height.mas_equalTo(29);
        }];


        
        SMLabel *countLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:chightLightgreenColor textFont:sysFont(14)];
        countLB.text = @"1.23456789";
        countLB.layer.borderWidth = 1 ;
        countLB.layer.borderColor = [UIColor clearColor] .CGColor;
        countLB.textAlignment = NSTextAlignmentCenter ;
        [addreduceImage addSubview:countLB];
        
        self.count =countLB ;
        [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0) ;
            make.centerX.equalTo(addreduceImage.mas_centerX);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
     
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:Image(@"add_image") forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addCoinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [addreduceImage addSubview:addBtn];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1) ;
            make.right.equalTo(addreduceImage.mas_right).with.offset(-1);
            make.width.mas_equalTo(29);
            make.height.mas_equalTo(29);
        }];


        SMLabel *dollarLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:chightLightgreenColor textFont:sysFont(11)];
        dollarLB.text = @"$ 123456.789";
        dollarLB.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:dollarLB];
        [dollarLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(addreduceImage.mas_bottom).with.offset(5) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(18);
        }];
        
        UIView *nameView = [UIView new];
        nameView.clipsToBounds = YES ;
        nameView.layer.borderWidth = 1 ;
        nameView.layer.borderColor = cDarkBorderColor.CGColor ;
        nameView.layer.cornerRadius = 5 ;
        [self addSubview:nameView];
        [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(dollarLB.mas_bottom).with.offset(30) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(MainScreenW/2-15);
            make.height.mas_equalTo(30);
        }];
        
        SMLabel *numberLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cDarkBlueColor textFont:sysFont(14)];
        numberLB.text = MyLocalized(@"count");
        numberLB.textAlignment = NSTextAlignmentLeft ;
        [nameView addSubview:numberLB];
        [numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameView.mas_top).with.offset(5) ;
            make.bottom.equalTo(nameView.mas_bottom).with.offset(-5) ;
            make.left.mas_equalTo(11);
            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(21);
        }];
        
        SMLabel *coinNameLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cDarkBlueColor textFont:sysFont(14)];
        coinNameLB.text = @"BTC";
        coinNameLB.textAlignment = NSTextAlignmentRight ;
        [nameView addSubview:coinNameLB];
        [coinNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameView.mas_top).with.offset(5) ;
            make.bottom.equalTo(nameView.mas_bottom).with.offset(-5) ;
            make.right.equalTo(nameView.mas_right).with.offset(-11);
            make.width.mas_equalTo(50);
        }];
        
        UITextField *texField = [[UITextField alloc] initWithFrame:CGRectZero];
        texField.textColor = cblueLightColor ;
        texField.font = sysFont(14);
        texField.textAlignment = NSTextAlignmentCenter ;
        [nameView addSubview:texField];
        [texField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0) ;
            make.centerX.centerY.equalTo(nameView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(21);
        }];
        
        SMLabel *availableLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:chightLightgreenColor textFont:sysFont(14)];
        availableLB.text = MyLocalized(@"available");
        availableLB.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:availableLB];
        [availableLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameView.mas_bottom).with.offset(8) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(21);
        }];
        
        SMLabel *ktcCountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cMoreHightLightgreenColor textFont:sysFont(14)];
        ktcCountLB.text = @"0.00000001ktc";
        ktcCountLB.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:ktcCountLB];
        [ktcCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameView.mas_bottom).with.offset(8) ;
            make.left.equalTo(availableLB.mas_right).with.offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(21);
        }];
        
        UIView *sliderView = [UIView new];
        sliderView.clipsToBounds = YES ;
        sliderView.layer.borderWidth = 1 ;
        sliderView.layer.borderColor = cDarkBorderColor.CGColor ;
        sliderView.layer.cornerRadius = 5 ;
        [self addSubview:sliderView];
        [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(availableLB.mas_bottom).with.offset(25) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(MainScreenW/2-15);
            make.height.mas_equalTo(30);
        }];
        
        SMLabel *currentValueLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cDarkBlueColor textFont:sysFont(12)];
        currentValueLB.text = @"0.00%";
        currentValueLB.textAlignment = NSTextAlignmentRight ;
        [sliderView addSubview:currentValueLB];
        self.currentSliderValueLB = currentValueLB ;
        [currentValueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sliderView) ;
            make.right.equalTo(sliderView.mas_right).with.offset(-11);
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(19);
        }];
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
        // 设置最小值
        slider.minimumValue = 0;
        // 设置最大值
        slider.maximumValue = 100;
        // 设置初始值
        slider.value = 0;
        // 设置可连续变化
        slider.continuous = YES;
        
        // 滑块颜色
        slider.thumbTintColor = cblueLightColor;
        // 走过的进度条的颜色
        slider.minimumTrackTintColor = [UIColor colorWithRed:54 / 256.0 green:148 / 256.0 blue:111 / 256.0 alpha:1];
        

        //滑轮左边颜色，如果设置了左边的图片就不会显示
        // slider.minimumTrackTintColor = [UIColor greenColor];
        
        //滑轮右边颜色，如果设置了右边的图片就不会显示
        // slider.thumbTintColor = [UIColor redColor];
        
        
        //设置了滑轮的颜色，如果设置了滑轮的样式图片就不会显示
         slider.maximumTrackTintColor = cblueLightColor;
        UIImage *imagea= [UIImage createRoundedRectImage:[self OriginImage:[UIImage imageWithColor:cblueLightColor] scaleToSize:CGSizeMake(13, 13)] size:CGSizeMake(13, 13) radius:6.5];
        [slider  setThumbImage:imagea forState:UIControlStateNormal];
        
    
        
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // 针对值变化添加响应方法
        [sliderView addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sliderView) ;
            make.left.mas_equalTo(5);
            make.right.equalTo(currentValueLB.mas_left).with.offset(-3);
            make.height.mas_equalTo(10);
        }];
    
        
        
        SMLabel *turnoverLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:chightLightgreenColor textFont:sysFont(14)];
        turnoverLB.text = MyLocalized(@"turnover");
        turnoverLB.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:turnoverLB];
        [turnoverLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sliderView.mas_bottom).with.offset(8) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(21);
        }];
        
        SMLabel *chooseCountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cMoreHightLightgreenColor textFont:sysFont(14)];
        chooseCountLB.text = @"0.00000001ktc";
        chooseCountLB.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:chooseCountLB];
        [chooseCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sliderView.mas_bottom).with.offset(8) ;
            make.left.equalTo(availableLB.mas_right).with.offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(21);
        }];
        
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.backgroundColor = cLightgreenColor ;
        [nextBtn setTitle:MyLocalized(@"buy") forState:UIControlStateNormal];
        [nextBtn setTitleColor:RGB_COLOR(196, 196, 196) forState:UIControlStateNormal];
        nextBtn.titleLabel.font = sysFont(14);
        nextBtn.clipsToBounds = YES ;
        nextBtn.layer.cornerRadius =10 ;
        [nextBtn addTarget:self action:@selector(buyCoinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(turnoverLB.mas_bottom).with.offset(28) ;
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(MainScreenW/2-15);
            make.height.mas_equalTo(34);
        }];
        
        
        
        for (int i = 0; i< 12 ; i++) {
            SMLabel *priceLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cBrickRedColor textFont:[UIFont fontWithName:@"Helvetica" size:11]];
            priceLB.textAlignment = NSTextAlignmentLeft ;
            [self addSubview:priceLB];
            [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(10 + i * 23) ;
                make.left.equalTo(addreduceImage.mas_right).with.offset(15);
                make.width.mas_equalTo(MainScreenW/4-15);
                make.height.mas_equalTo(18);
            }];
            
            SMLabel *CountLB = [[SMLabel alloc] initWithFrameWith:CGRectZero textColor:cMoreHightLightgreenColor textFont:[UIFont fontWithName:@"Helvetica" size:11]];
            CountLB.textAlignment = NSTextAlignmentRight ;
            [self addSubview:CountLB];
            [CountLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(10 + i * 23) ;
                make.right.equalTo(self.mas_right).with.offset(-15);
                make.width.mas_equalTo(MainScreenW/2-15);
                make.height.mas_equalTo(18);
            }];
            
            if (i==0) {
                priceLB.text = [NSString stringWithFormat:@"%@(HKT)",MyLocalized(@"price")];
                priceLB.font = [UIFont fontWithName:@"PingFangSC-Medium" size:11];
                priceLB.textColor = cDarkBlueColor ;
                CountLB.text = [NSString stringWithFormat:@"%@(BTC)",MyLocalized(@"count")];
                CountLB.font = [UIFont fontWithName:@"PingFangSC-Medium" size:11];
                CountLB.textColor = cDarkBlueColor ;
            } else if(i>6){
                priceLB.text = @"469876.54";
                CountLB.text = @"0.9999";
                [priceLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).with.offset(10 + (i-1) * 23 + 17+17 +18) ;
                    make.height.mas_equalTo(18);
                    
                }];
                [CountLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).with.offset(10 + (i-1) * 23 + 17+17 +18) ;
                    make.height.mas_equalTo(18);
                    
                }];
            }else{
             
                if (i==6) {
                    priceLB.text = @"469876.54";
                    CountLB.text = @"≈49323.99";
                    priceLB.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
                    CountLB.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
                    priceLB.textColor = cDarkBlueColor ;
                    CountLB.textColor = cMoreHightLightgreenColor ;
                    [priceLB mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.mas_top).with.offset(10 + i * 23 + 17) ;
                        make.height.mas_equalTo(21);

                    }];
                    [CountLB mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.mas_top).with.offset(10 + i * 23 + 17) ;
                        make.height.mas_equalTo(21);

                    }];
                    
                    UILabel *topLIneLB = [UILabel new];
                    topLIneLB.backgroundColor = clinecolor ;
                    [self addSubview:topLIneLB];
                    [topLIneLB mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.mas_top).with.offset(10  + i * 23 + 10) ;
                        make.right.equalTo(self.mas_right).with.offset(-15);
                        make.width.mas_equalTo(MainScreenW/2-30);
                        make.height.mas_equalTo(1);
                    }];
                    
                    UILabel *bottomLIneLB = [UILabel new];
                    bottomLIneLB.backgroundColor = clinecolor ;
                    [self addSubview:bottomLIneLB];
                    [bottomLIneLB mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.mas_top).with.offset(10 +  i * 23 + 17 + 21 + 7) ;
                        make.right.equalTo(self.mas_right).with.offset(-15);
                        make.width.mas_equalTo(MainScreenW/2-30);
                        make.height.mas_equalTo(1);
                    }];
                    
                }else{
                    priceLB.text = @"469876.54";
                    CountLB.text = @"49323.99";
                }
            }
            
            
        };
    }
    return self;
}
- (void)reduceCoinClicked:(UIButton*)btn{
    
}
- (void)addCoinClicked:(UIButton*)btn{
    
}
- (void)buyCoinClicked:(UIButton*)btn{
    
}

- (void)sliderValueChanged:(UISlider *)slider{
    UISlider *slide = (UISlider *)slider;
    self.currentSliderValueLB.text = [NSString stringWithFormat:@"%.2f%%", slide.value];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    //size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}
    
    

@end
