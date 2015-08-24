//
//  UIButton+CHXControlState.m
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

#import "UIButton+CHXControlState.h"
#import "UIImage+CHXMaker.h"

@implementation UIButton (CHXControlState)

- (void)chx_setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)chx_setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:[color colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
    [self setTitleColor:[color colorWithAlphaComponent:0.2] forState:UIControlStateSelected];
}

- (void)chx_setTitleShadowColor:(UIColor *)color {
    [self setTitleShadowColor:color forState:UIControlStateNormal];
    [self setTitleShadowColor:color forState:UIControlStateHighlighted];
    [self setTitleShadowColor:[color colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
    [self setTitleShadowColor:[color colorWithAlphaComponent:0.2] forState:UIControlStateSelected];
}

- (void)chx_setImage:(UIImage *)image {
    UIImage *originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setImage:originalImage forState:UIControlStateNormal];
    [self setImage:originalImage forState:UIControlStateHighlighted];
}

- (void)chx_setBackgroundImage:(UIImage *)image {
    UIImage *originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setBackgroundImage:originalImage forState:UIControlStateNormal];
    [self setBackgroundImage:originalImage forState:UIControlStateHighlighted];
}

- (void)chx_setBackgroundColor:(UIColor *)color {
    UIImage *image = [UIImage chx_imageWithColor:color];
    self.backgroundColor = [color colorWithAlphaComponent:0.2];
    [self chx_setBackgroundImage:image];
}

- (void)chx_setAttributedTitle:(NSAttributedString *)title {
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:title forState:UIControlStateHighlighted];
}


@end
