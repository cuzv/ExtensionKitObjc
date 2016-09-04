//
//  UIButton+EKExtension.h
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

#import <UIKit/UIKit.h>

@interface UIButton (EKExtension)

#pragma mark - Properties

@property (nullable, nonatomic, copy) NSString *ek_title;
@property (nullable, nonatomic, strong) UIFont *ek_titleFont;
@property (nullable, nonatomic, copy) NSAttributedString *ek_attributeTitle;
@property (nullable, nonatomic, strong) UIColor *ek_titleColor;
@property (nullable, nonatomic, strong) UIColor *ek_titleShadowColor;
@property (nullable, nonatomic, strong) UIImage *ek_image;
@property (nullable, nonatomic, strong) UIImage *ek_selectedImage;
@property (nullable, nonatomic, strong) UIImage *ek_backgroundImage;
@property (nullable, nonatomic, strong) UIImage *ek_selectedBackgroundImage;
@property (nullable, nonatomic, strong) UIImage *ek_disabledBackgroundImage;

#pragma mark - Image & Title

- (void)ek_setImageAlignToTopWithMargin:(CGFloat)margin;
- (void)ek_setImageAlignToLeftWithMargin:(CGFloat)margin;
- (void)ek_setImageAlignToBottomWithMargin:(CGFloat)margin;
- (void)ek_setImageAlignToRightWithMargin:(CGFloat)margin;

#pragma mark - Animation
// Override UIView extensions

@end
