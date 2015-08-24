//
//  UIView+CHXArcRotationAnimation.m
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIView+CHXArcRotationAnimation.h"
#import "NSObject+CHXAssociatedObject.h"
#import "CHXGlobalServices.h"

static const void *ArcLayerKey = @"arcLayer";

@implementation UIView (CHXArcRotationAnimation)

- (void)pr_setArcLayer:(CAShapeLayer *)arcLayer {
    [self chx_associateWeaklyObject:arcLayer forKey:ArcLayerKey];
}

- (CAShapeLayer *)pr_arcLayer {
    return [self chx_associatedObjectForKey:ArcLayerKey];
}

- (void)chx_addArcShapeLayerWithColor:(UIColor *)strokeColor {
    [self.layer addSublayer:[self pr_arcShapeLayerWithColor:strokeColor]];
}

- (CAShapeLayer *)pr_arcShapeLayerWithColor:(UIColor *)strokeColor {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.bounds;
    CGFloat half = MIN(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
                    radius:half
                startAngle:chx_angleToRadian(-90)
                  endAngle:chx_angleToRadian(270)
                 clockwise:YES];
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [strokeColor CGColor] ? : [[UIColor lightGrayColor] CGColor];
    arcLayer.lineWidth = 2;
    arcLayer.frame = rect;
    
    return arcLayer;
}

- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration {
    [self chx_addArcRotationAnimaionWithDuration:duration lineColor:[UIColor blueColor]];
}

- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color {
    if ([self pr_arcLayer]) {
        return;
    }
    // 添加 layer
    CAShapeLayer *arcLayer = [self pr_arcShapeLayerWithColor:color];
    [self pr_setArcLayer:arcLayer];
    [self.layer addSublayer:arcLayer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [arcLayer addAnimation:animation forKey:@"animation"];
}

- (void)chx_removeArcRotationAnimation {
    [[self pr_arcLayer] removeAllAnimations];
    [[self pr_arcLayer] removeFromSuperlayer];
    [self pr_setArcLayer:nil];
}


@end
