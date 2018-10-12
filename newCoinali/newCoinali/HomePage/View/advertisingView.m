//
//  advertising.m
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/29.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "advertisingView.h"
#import "SDCycleScrollView.h"

@interface advertisingView   ()<SDCycleScrollViewDelegate>

@end

@implementation advertisingView
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray*)imageArr titleArray:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15,0, MainScreenW-30, 101.0/345*MainScreenW) delegate:self placeholderImage:Default_Image];
        cycleScrollView.clipsToBounds = YES ;
        cycleScrollView.layer.cornerRadius = 15 ;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.bannerImageViewContentMode =UIViewContentModeScaleToFill;
        cycleScrollView.currentPageDotColor = cLightWhiteColor;
        cycleScrollView.pageDotColor = cWhiteColor;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        cycleScrollView.autoScrollTimeInterval = 2.0;
        cycleScrollView.userInteractionEnabled = YES ;
        [self addSubview:cycleScrollView];
        //         --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView.imageURLStringsGroup = imageArr;
        });
        //block监听点击方式
        cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            self.selectBlock(KP_HpomePageAD);

        };
        
        
        SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, cycleScrollView.bottom+10, MainScreenW, 40) delegate:self placeholderImage:nil];
        cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
        cycleScrollView4.onlyDisplayText = YES;
        cycleScrollView4.titlesGroup = titleArray;
        cycleScrollView4.titleLabelBackgroundColor = cBgColor ;
        [cycleScrollView4 disableScrollGesture];
        
        [self addSubview:cycleScrollView4];
        cycleScrollView4.clickItemOperationBlock = ^(NSInteger index) {
            self.selectBlock(KP_HpomePageMessage);
        };
    }
    return self;
}

@end
