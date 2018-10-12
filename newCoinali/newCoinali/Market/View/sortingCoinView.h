//
//  sortingCoinView.h
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/9.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface sortingCoinView : UIView


@property (nonatomic , copy)DidSelectBlock didClickedBlock ;
- (id)initWithFrame:(CGRect)frame btnArr:(NSArray*)btnArr;
@end

NS_ASSUME_NONNULL_END
