//
//  accountMessageView.h
//  coinali
//
//  Created by 开拍网ios研发 on 2018/9/30.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface accountMessageView : UIView


@property (nonatomic,copy) DidSelectBlock selectBlock;

//login 是否登录
- (id)initWithFrame:(CGRect)frame type:(personPropertyMessageType)type;
@end

NS_ASSUME_NONNULL_END
