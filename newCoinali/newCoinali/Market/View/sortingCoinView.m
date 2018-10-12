//
//  sortingCoinView.m
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/9.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "sortingCoinView.h"

@implementation sortingCoinView

- (id)initWithFrame:(CGRect)frame btnArr:(NSArray*)btnArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i = 0; i<btnArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:btnArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cblueLightColor forState:UIControlStateNormal];
            [btn setImage:Image(@"shunRank") forState:UIControlStateNormal];
            [btn setImage:Image(@"inverse") forState:UIControlStateSelected];
            btn.titleLabel.font = sysFont(11);
            btn.tag = 10 +i ;
            [btn addTarget:self action:@selector(chooseRankClicked:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(11);
                 make.width.mas_equalTo(80);
                 make.height.mas_equalTo(18);
                if (i==0) {
                    make.left.mas_equalTo(15);

                }else if (i==1){
                    make.centerX.equalTo(self.mas_centerX).with.offset(0);
                }
                else {
                    make.right.equalTo(self.mas_right).with.offset(-13);

                }
            }];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:2];

        };

    }
    return self;
}
- (void)chooseRankClicked:(UIButton*)btn{
    btn.selected = !btn.selected ;
    self.didClickedBlock(btn.tag) ;
}
@end
