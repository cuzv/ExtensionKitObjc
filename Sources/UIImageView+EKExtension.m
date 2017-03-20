//
//  UIImageView+EKExtension.m
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

#import "UIImageView+EKExtension.h"
#import "UIView+EKExtension.h"
#import "UIImage+EKExtension.h"

@implementation UIImageView (EKExtension)

- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth {
    if (self.ek_isRoundingCornersExists) {
        return;
    }
    if (CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        NSLog(@"Could not set rounding corners on zero size view.");
        return;
    }
    if (!self.image) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat scale = MAX(self.image.size.width / self.frame.size.width, self.frame.size.height / self.frame.size.height);
        CGFloat relatedRadius = scale * radius;
        CGFloat relatedStrokeLineWidth = scale * strokeLineWidth;
        UIImage *newImage = [self.image ek_imageWithRoundingCorners:roundingCorners
                                                             radius:relatedRadius
                                                        strokeColor:strokeColor
                                                    strokeLineWidth:relatedStrokeLineWidth
                                                     strokeLineJoin:kCGLineJoinMiter];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.backgroundColor = [UIColor clearColor];
            self.image = newImage;
            
            [self setValue:@(YES) forKey:NSStringFromSelector(@selector(ek_isRoundingCornersExists))];
        });
    });
}

@end
