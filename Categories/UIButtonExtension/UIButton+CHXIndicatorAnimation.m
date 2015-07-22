//
//  UIButton+CHXIndicatorAnimation.m
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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

#import "UIButton+CHXIndicatorAnimation.h"
#import "CHXGapRing.h"
#import <objc/runtime.h>
#import "UIColor+CHXRandomColor.h"
#import "UIView+CHXAccessor.h"
#import "NSObject+CHXAssociatedObject.h"

@implementation UIButton (CHXIndicatorAnimation)

static const void *IndicatorAnimationKey = @"animating";
static const void *IndicatorAnimationContextKey = @"context";

- (void)pr_setAnimating:(BOOL)animating {
    [self chx_associateObject:@(animating) forKey:IndicatorAnimationKey];
}

- (BOOL)pr_animating {
    return [objc_getAssociatedObject(self, IndicatorAnimationKey) boolValue];
}

- (void)pr_setContext:(NSDictionary *)context {
    [self chx_associateObject:context forKey:IndicatorAnimationContextKey];
}

- (NSDictionary *)pr_context {
    return objc_getAssociatedObject(self, IndicatorAnimationContextKey);
}

#pragma mark -

- (void)chx_addWaitingAnimation {
    if ([self pr_animating]) {
        return;
    }
    
    // 保存上下文数据
    [self pr_setContext:({
        NSMutableDictionary *context = [NSMutableDictionary new];
        
        id normalimage = [self imageForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalimage forKey:@"normalimage"];
        id highlightedImage = [self imageForState:UIControlStateHighlighted] ? : [NSNull null];
        [context setObject:highlightedImage forKey:@"highlightedImage"];
        id selectedImage = [self imageForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedImage forKey:@"selectedImage"];
        
        id normalBackgroundImage = [self backgroundImageForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalBackgroundImage forKey:@"normalBackgroundImage"];
        id highlightedBackgroundImage = [self backgroundImageForState:UIControlStateHighlighted] ? : [NSNull null];
        [context setObject:highlightedBackgroundImage forKey:@"highlightedBackgroundImage"];
        id selectedBackgroundImage = [self backgroundImageForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedBackgroundImage forKey:@"selectedBackgroundImage"];
        
        id normalTitle = [self titleForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalTitle forKey:@"normalTitle"];
        id highlightedTitle = [self titleForState:UIControlStateHighlighted]  ? : [NSNull null];
        [context setObject:highlightedTitle forKey:@"highlightedTitle"];
        id selectedTitle = [self titleForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedTitle forKey:@"selectedTitle"];
        
        id backgroundColor = self.backgroundColor ? : [NSNull null];
        [context setObject:backgroundColor forKey:@"backgroundColor"];
        
        context;
    })];
    
    // 干掉之前的数据
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateHighlighted];
    [self setImage:nil forState:UIControlStateSelected];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setBackgroundImage:nil forState:UIControlStateSelected];
    
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateHighlighted];
    [self setTitle:nil forState:UIControlStateSelected];
    
    self.backgroundColor = [UIColor clearColor];
    
    // 添加动画
    CGFloat lengthOfSide = [self height] * 0.8;
    CHXGapRing *gapRing = [[CHXGapRing alloc] initWithFrame:CGRectMake(0, 0, lengthOfSide, lengthOfSide)];
    [gapRing setMidX:[self width] / 2];
    [gapRing setMidY:[self height] / 2];
    gapRing.lineColor = [UIColor chx_colorWithRGBA:@[@0, @122, @255, @1]];
    [gapRing startAnimation];
    [self addSubview:gapRing];
    
    [self pr_setAnimating:YES];
}

- (void)chx_removeWaitingAnimation {
    if (![self pr_animating]) {
        return;
    }
    
    // 移除动画
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[CHXGapRing class]]) {
            CHXGapRing *gapRing = (CHXGapRing *)subView;
            [gapRing stopAnimation];
            [gapRing removeFromSuperview];
            gapRing = nil;
            break;
        }
    }
    
    // 恢复上下文信息
    id context = [self pr_context];
    
    Class imageClass = [UIImage class];
    
    id normalimage = [context objectForKey:@"normalimage"];
    if ([normalimage isKindOfClass:imageClass]) {
        [self setImage:normalimage forState:UIControlStateNormal];
    }
    id highlightedImage = [context objectForKey:@"highlightedImage"];
    if ([highlightedImage isKindOfClass:imageClass]) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    id selectedImage = [context objectForKey:@"selectedImage"];
    if ([selectedImage isKindOfClass:imageClass]) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    
    id normalBackgroundImage = [context objectForKey:@"normalBackgroundImage"];
    if ([normalBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:normalBackgroundImage forState:UIControlStateNormal];
    }
    id highlightedBackgroundImage = [context objectForKey:@"highlightedBackgroundImage"];
    if ([highlightedBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
    id selectedBackgroundImage = [context objectForKey:@"selectedBackgroundImage"];
    if ([selectedBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:selectedBackgroundImage forState:UIControlStateSelected];
    }
    
    Class stringClass = [NSString class];
    
    id normalTitle = [context objectForKey:@"normalTitle"];
    if ([normalTitle isKindOfClass:stringClass]) {
        [self setTitle:normalTitle forState:UIControlStateNormal];
    }
    id highlightedTitle = [context objectForKey:@"highlightedTitle"];
    if ([highlightedTitle isKindOfClass:stringClass]) {
        [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
    }
    id selectedTitle = [context objectForKey:@"selectedTitle"];
    if ([selectedTitle isKindOfClass:stringClass]) {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
    id backgroundColor = [context objectForKey:@"backgroundColor"];
    if ([backgroundColor isKindOfClass:[UIColor class]]) {
        self.backgroundColor = backgroundColor;
    }
    
    [self pr_setAnimating:NO];
}

- (BOOL)chx_isAnimating {
    return [self pr_animating];
}


@end
