//
//  FallOrRoseVIew.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/9.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "FallOrRoseVIew.h"

@interface FallOrRoseVIew ()
{
    UIButton *_forBtn ;
}
@end

@implementation FallOrRoseVIew

- (id)initWithFrame:(CGRect)frame btnArr:(NSArray*)btnArr
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<btnArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:btnArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cWhiteColor forState:UIControlStateSelected];
            [btn setTitleColor:cDarkBlueColor forState:UIControlStateNormal];
            btn.titleLabel.font = sysFont(15);
            btn.tag = 10+i ;
            [btn addTarget:self action:@selector(changeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(22);
                if (i==0) {
                    make.centerX.equalTo(self.mas_centerX ).with.offset((-1)*MainScreenW/4);
                    btn.selected = YES ;
                } else {
                    make.centerX.equalTo(self.mas_centerX ).with.offset(MainScreenW/4);

                }
            }];
            
        };

        UILabel *lineLB = [UILabel new];
        lineLB.backgroundColor = [UIColor colorWithRed:78/255.0 green:122/255.0 blue:191/255.0 alpha:1/1.0] ;
        lineLB.tag = 99 ;
        [self addSubview:lineLB];
        [lineLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.equalTo(self.mas_left).with.offset(15);
            make.width.mas_equalTo(MainScreenW/2-30);
            make.height.mas_equalTo(2);
           
        }];
    }
    return self;
}
- (void)changeClicked:(UIButton *)btn{
    
    _forBtn.selected = NO;
    _forBtn = btn;
    _forBtn.selected = YES;
    self.selectBlock(btn.tag) ;
    
    UILabel *label = (UILabel *)[self viewWithTag:99];
    [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            if (btn.tag==11) {
                make.left.equalTo(self.mas_left).with.offset(MainScreenW/2+15);
            } else {
                make.left.equalTo(self.mas_left).with.offset(15);
                
            }
        }];
    } completion:^(BOOL finished) {
        
    }];
}
@end
