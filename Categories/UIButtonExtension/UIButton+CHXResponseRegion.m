//
//  UIButton+CHXResponseRegion.m
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

#import "UIButton+CHXResponseRegion.h"
#import "NSObject+CHXAssociatedObject.h"

static const void * ResponseRegion = @"chx_responseRegion";

@implementation UIButton (CHXResponseRegion)

- (void)setChx_responseRegion:(UIEdgeInsets)chx_responseRegion {
    [self chx_associateObject:[NSValue valueWithUIEdgeInsets:chx_responseRegion] forKey:ResponseRegion];
}

- (UIEdgeInsets)chx_responseRegion {
    return [[self chx_associatedObjectForKey:ResponseRegion] UIEdgeInsetsValue];
}

- (CGRect)clickRegional {
    UIEdgeInsets inset = [self chx_responseRegion];
    CGFloat top = inset.top;
    CGFloat bottom = inset.bottom;
    CGFloat left = inset.left;
    CGFloat right = inset.right;
    BOOL regional = top || bottom || left || right;
    if (regional) {
        return CGRectMake(self.bounds.origin.x - left,
                          self.bounds.origin.y - top,
                          self.bounds.size.width + left + right,
                          self.bounds.size.height + top + bottom);
    } else {
        return self.bounds;
    }
}

// Override
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self clickRegional];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

- (void)chx_setResponseRegion:(UIEdgeInsets)chx_responseRegion {
    [self setChx_responseRegion:chx_responseRegion];
}

@end
