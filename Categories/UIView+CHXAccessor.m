//
//  UIView+CHXAccessor.m
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

#import "UIView+CHXAccessor.h"

@implementation UIView (CHXAccessor)

- (void)setOrigin:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.minX, self.minY, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setMinX:(CGFloat)x {
    self.frame = CGRectMake(x, self.minY, self.width, self.height);
}

- (CGFloat)minX {
    return self.frame.origin.x;
}

- (void)setMidX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width / 2, self.minY, self.width, self.height);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (void)setMaxX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width, self.minY, self.width, self.height);
}

- (CGFloat)maxX {
    return self.minX + self.width;
}

- (void)setMinY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y, self.width, self.height);
}

- (CGFloat)minY {
    return self.frame.origin.y;
}

- (void)setMidY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height / 2, self.width, self.height);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (void)setMaxY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height, self.width, self.height);
}

- (CGFloat)maxY {
    return self.minY + self.height;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.minX, self.minY, width, self.height);
}

- (CGFloat)width {
    return CGRectGetWidth(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.minX, self.minY, self.width, height);
}

- (CGFloat)height {
    return CGRectGetHeight(self.bounds);
}

@end
