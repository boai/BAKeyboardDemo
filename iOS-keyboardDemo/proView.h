//
//  proView.h
//  iOS-keyboardDemo
//
//  Created by 博爱之家 on 16/5/18.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BACircleProgressLayer.h"

@interface proView : UIView

@property (nonatomic, strong) BACircleProgressLayer *circleProgressLayer;
@property (nonatomic, strong) UILabel * progressLabel;

@property (nonatomic, assign) CGFloat progress;

@end
