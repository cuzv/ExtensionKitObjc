//
//  UINavigationBar+EKExtension.m
//  Copyright (c) 2014-2016 Moch Xiao (http://mochxiao.com).
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

#import "UINavigationBar+EKExtension.h"
#import "EKMacro.h"

@implementation UINavigationBar (EKExtension)

- (nullable UIView *)ek_hairline {
    Class clazz = NSClassFromString(@"_UINavigationBarBackground");
    if (!clazz) {
        return nil;
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:clazz]) {
            for (UIView *subview in view.subviews) {
                if ([subview isKindOfClass:UIImageView.class] &&
                    CGRectGetHeight(subview.bounds) == 1.0f / UIScreen.mainScreen.scale) {
                    return subview;
                }
            }
        }
    }
    
    return nil;
}

- (void)ek_setBackgroundVisible:(BOOL)visible {
    if (!self.translucent) {
        NSLog(@"%@", @"`translucent` must be true if you wanna change background visible.");
        return;
    }
}



@end
