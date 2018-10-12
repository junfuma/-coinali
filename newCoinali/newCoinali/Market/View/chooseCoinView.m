//
//  chooseCoinView.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/9.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "chooseCoinView.h"


@interface chooseCoinView ()<UIScrollViewDelegate>
{
     UIButton *_forBtn ;
}
@property (nonatomic , strong)UIScrollView *scrollerView ;

@end
@implementation chooseCoinView

- (id)initWithFrame:(CGRect)frame btnArr:(NSArray*)btnArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = cBgColor ;
        
        UIScrollView *scrolleView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scrolleView.scrollEnabled = YES ;
        scrolleView.pagingEnabled = YES;
//        scrolleView.bounces = YES ;
        scrolleView.delegate = self ;
        scrolleView.directionalLockEnabled = YES;

        self.scroller = scrolleView ;
        [self addSubview:scrolleView];
        self.scrollerView = scrolleView ;
        [scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.height.equalTo(self);
            
        }];
        scrolleView.contentSize = CGSizeMake(31 + 100 * btnArr.count, frame.size.height);
        for (int i = 0; i<btnArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:btnArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cDarkBlueColor forState:UIControlStateNormal];
            [btn setTitleColor:cblueLightColor forState:UIControlStateSelected];
            btn.titleLabel.font = boldFont(15);
            btn.tag = 10 +i ;
            [btn addTarget:self action:@selector(chooseRankClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrolleView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(11);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(18);
                make.left.mas_equalTo(31+(31+63)*i);

            }];
//            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
        };

        UILabel *lineLB = [UILabel new];
        lineLB.backgroundColor = [UIColor colorWithRed:78/255.0 green:122/255.0 blue:191/255.0 alpha:1/1.0] ;
       
        self.cursorLB = lineLB;
        [self addSubview:lineLB];
        [lineLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            make.left.equalTo(self.mas_left).with.offset(35);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(2);
            
        }];
        
    }
    return self;
}
- (void)chooseRankClicked:(UIButton*)btn{
    _forBtn.selected = NO;
    _forBtn = btn;
    _forBtn.selected = YES;
    
    self.didClickedBlock(btn.tag) ;
    

    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(35 + (31+63)*(btn.tag-10) - self.scrollerView.contentOffset.x);
        
        }];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f,%f",point.x,point.y);
    //     从中可以读取contentOffset属性以确定其滚动到的位置。
    //
    //     注意：当ContentSize属性小于Frame时，将不会出发滚动
    
    if (point.x<90) {
        
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(self.cursorLB.frame.origin.x - point.x);
                
            }];
        } completion:^(BOOL finished) {
            
        }];
    }
    if (point.x<0) {
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.cursorLB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(35 );
                
            }];
        } completion:^(BOOL finished) {
            
        }];
    }
}
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
   
    
}
@end
