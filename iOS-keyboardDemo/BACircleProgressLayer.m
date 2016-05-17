//
//  BACircleProgressLayer.m
//  iOS-keyboardDemo
//
//  Created by 博爱之家 on 16/5/18.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BACircleProgressLayer.h"

@implementation BACircleProgressLayer

/*! 重载其绘图方法 drawInContext，并在progress属性变化时让其重绘 */
- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat lineWidth = 10.0;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - lineWidth / 2 startAngle:0.f endAngle:M_PI * 2 * self.progress clockwise:YES];
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 1.0);//笔颜色
    CGContextSetLineWidth(ctx, 10);//线条宽度
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

/*! 重载 needsDisplayForKey方法指定progress属性变化时进行重绘 */
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

/*! 重载initWithLayer方法 */
- (instancetype)initWithLayer:(BACircleProgressLayer *)layer
{
    NSLog(@"initLayer");
    if (self = [super initWithLayer:layer]) {
        self.progress = layer.progress;
    }
    return self;
}


@end
