//
//  UIButton+CHXImageAlignment.m
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

#import "UIButton+CHXImageAlignment.h"

@implementation UIButton (CHXImageAlignment)

- (void)chx_updateImageAlignmentToRight {
    [self chx_updateImageAlignmentToRightWithSpace:0];
}

- (void)chx_updateImageAlignmentToRightWithSpace:(CGFloat)space {
    CGFloat halfSpace = space / 2.0f;

    CGFloat imageWidth = self.currentImage.size.width;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-halfSpace, 0, imageWidth+halfSpace)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, edgeWidth+halfSpace, 0, -edgeWidth-halfSpace)];
}

- (void)chx_updateImageAlignmentToUp {
    [self chx_updateImageAlignmentToUpWithSpace:0];
}

- (void)chx_updateImageAlignmentToUpWithSpace:(CGFloat)space {
    CGFloat halfSpace = space / 2.0f;
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight/2 + halfSpace, -imageWidth/2, -imageHeight/2 - halfSpace, imageWidth/2)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat edgeHeight = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    [self setImageEdgeInsets:UIEdgeInsetsMake(-edgeHeight/2 - halfSpace, edgeWidth / 2, edgeHeight/2 + halfSpace, -edgeWidth/2)];
}

@end
