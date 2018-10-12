//
//  FallOrRoseVIew.h
//  newCoinali
//
//  Created by 开拍网ios研发 on 2018/10/9.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FallOrRoseVIew : UIView


@property (nonatomic,copy) DidSelectBlock selectBlock;

- (id)initWithFrame:(CGRect)frame  btnArr:(NSArray*)btnArr;
@end

NS_ASSUME_NONNULL_END
