//
//  UIButton+EKExtension.m
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

#import "UIButton+EKExtension.h"
#import "UIImage+EKExtension.h"
#import "UIView+EKExtension.h"
#import "EKCoreLibsExtension.h"

@implementation UIButton (EKExtension)

#pragma mark - Properties

- (nullable NSString *)ek_title {
    return [self titleForState:UIControlStateNormal];
}

- (void)setEk_title:(NSString *)ek_title {
    [self setTitle:ek_title forState:UIControlStateNormal];
}

- (nullable UIFont *)ek_titleFont {
    return self.titleLabel.font;
}

- (void)setEk_titleFont:(nullable UIFont *)ek_titleFont {
    self.titleLabel.font = ek_titleFont;
}

- (nullable NSAttributedString *)ek_attributeTitle {
    return [self attributedTitleForState:UIControlStateNormal];
}

- (void)setEk_attributeTitle:(nullable NSAttributedString *)ek_attributeTitle {
    [self setAttributedTitle:ek_attributeTitle forState:UIControlStateNormal];
}

- (nullable UIColor *)ek_titleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setEk_titleColor:(nullable UIColor *)ek_titleColor {
    [self setTitleColor:ek_titleColor forState:UIControlStateNormal];
    [self setTitleColor:ek_titleColor forState:UIControlStateSelected];
    [self setTitleColor:[ek_titleColor colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    if (self.buttonType == UIButtonTypeCustom) {
        [self setTitleColor:[ek_titleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    }
}

- (nullable UIColor *)ek_titleShadowColor {
    return [self titleShadowColorForState:UIControlStateNormal];
}

- (void)setEk_titleShadowColor:(nullable UIColor *)ek_titleShadowColor {
    [self setTitleShadowColor:ek_titleShadowColor forState:UIControlStateNormal];
    [self setTitleShadowColor:ek_titleShadowColor forState:UIControlStateSelected];
    [self setTitleShadowColor:[ek_titleShadowColor colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
}

- (nullable UIImage *)ek_image {
    return [self imageForState:UIControlStateNormal];
}

- (void)setEk_image:(nullable UIImage *)ek_image {
    [self setImage:ek_image.ek_original forState:UIControlStateNormal];
}

- (nullable UIImage *)ek_selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setEk_selectedImage:(nullable UIImage *)ek_selectedImage {
    [self setImage:ek_selectedImage.ek_original forState:UIControlStateSelected];
}

- (nullable UIImage *)ek_backgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setEk_backgroundImage:(UIImage *)ek_backgroundImage {
    [self setBackgroundImage:ek_backgroundImage.ek_original forState:UIControlStateNormal];
    if (self.buttonType == UIButtonTypeCustom) {
        [self setBackgroundImage:[ek_backgroundImage.ek_original ek_renderUsingAlpha:0.5] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[ek_backgroundImage.ek_original ek_renderUsingAlpha:0.5] forState:UIControlStateDisabled];
    }
}

- (nullable UIImage *)ek_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setEk_selectedBackgroundImage:(nullable UIImage *)ek_selectedBackgroundImage {
    [self setBackgroundImage:ek_selectedBackgroundImage.ek_original forState:UIControlStateSelected];
}

- (nullable UIImage *)ek_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setEk_disabledBackgroundImage:(UIImage *)ek_disabledBackgroundImage {
    [self setBackgroundImage:ek_disabledBackgroundImage.ek_original forState:UIControlStateDisabled];
}


#pragma mark - Image & Title

- (void)ek_setImageAlignToTopWithMargin:(CGFloat)margin {
    if (!self.currentImage || !self.currentTitle || !self.titleLabel) {
        return;
    }
    
    CGFloat halfSpace = ceil(margin / 2.0f);
    CGFloat halfImageWidth = ceil(self.currentImage.size.width / 2.0f);
    CGFloat halfImageHeight = ceil(self.currentImage.size.height / 2.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(halfImageHeight + halfSpace, -halfImageWidth, -halfImageHeight - halfSpace, halfImageWidth);
    
    CGSize titleSize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGFloat halfEdgeWidth = ceil(titleSize.width / 2.0f);
    CGFloat halfEdgeHeight = ceil(titleSize.height / 2.0f);
    self.imageEdgeInsets = UIEdgeInsetsMake(-halfEdgeHeight - halfSpace, halfEdgeWidth, halfEdgeHeight + halfSpace, -halfEdgeWidth);
}

- (void)ek_setImageAlignToLeftWithMargin:(CGFloat)margin {
    CGFloat halfSpace = ceil(margin / 2.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, halfSpace, 0, -halfSpace);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -halfSpace, 0, halfSpace);
}

- (void)ek_setImageAlignToBottomWithMargin:(CGFloat)margin {
    if (!self.currentImage || !self.currentTitle || !self.titleLabel) {
        return;
    }
    
    CGFloat halfSpace = ceil(margin / 2.0f);
    CGFloat halfImageWidth = ceil(self.currentImage.size.width / 2.0f);
    CGFloat halfImageHeight = ceil(self.currentImage.size.height / 2.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(-halfImageHeight - halfSpace, -halfImageWidth, halfImageHeight + halfSpace, halfImageWidth);
    
    CGSize titleSize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGFloat halfEdgeWidth = ceil(titleSize.width / 2.0f);
    CGFloat halfEdgeHeight = ceil(titleSize.height / 2.0f);
    self.imageEdgeInsets = UIEdgeInsetsMake(halfEdgeHeight + halfSpace, halfEdgeWidth, -halfEdgeHeight - halfSpace, -halfEdgeWidth);
}

- (void)ek_setImageAlignToRightWithMargin:(CGFloat)margin {
    if (!self.currentImage || !self.currentTitle || !self.titleLabel) {
        return;
    }
    
    CGFloat halfSpace = ceil(margin / 2.0f);
    CGFloat imageWidth = ceil(self.currentImage.size.width);
    CGFloat edgeWidth = ceil([self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - halfSpace, 0, imageWidth + halfSpace);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, edgeWidth + halfSpace, 0, -edgeWidth - halfSpace);
}


#pragma mark - Animation

- (void)ek_satrtActivityIndicatorAnimation {
    if (self.ek_activityIndicatorContainerView) {
        if (self.ek_activityIndicatorContainerView.ek_isActivityIndicatorAnimating) {
            return;
        }
        [self.ek_activityIndicatorContainerView ek_satrtActivityIndicatorAnimation];
        self.ek_activityIndicatorContainerView.hidden = NO;
        return;
    }
    
    UIView *containerView = [UIView new];
    containerView.ek_cornerRadius = self.ek_cornerRadius;
    containerView.userInteractionEnabled = NO;
    [containerView ek_satrtActivityIndicatorAnimation];
    [self ek_addSubview:containerView];
    containerView.backgroundColor = self.ek_bgColor;
    self.ek_activityIndicatorContainerView = containerView;
}

- (void)ek_stopActivityIndicatorAnimation {
    if (self.ek_activityIndicatorContainerView &&
        !self.ek_activityIndicatorContainerView.ek_isActivityIndicatorAnimating) {
        return;
    }
    
    [self.ek_activityIndicatorContainerView ek_stopActivityIndicatorAnimation];
    self.ek_activityIndicatorContainerView.hidden = YES;
}

- (BOOL)ek_isActivityIndicatorAnimating {
    return self.ek_activityIndicatorContainerView.ek_isActivityIndicatorAnimating;
}

- (nullable UIView *)ek_activityIndicatorContainerView {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_activityIndicatorContainerView:(nullable UIView *)ek_activityIndicatorContainerView {
    EKSetAssociatedObject(self, @selector(ek_activityIndicatorContainerView), ek_activityIndicatorContainerView, OBJC_ASSOCIATION_ASSIGN);
}


@end
