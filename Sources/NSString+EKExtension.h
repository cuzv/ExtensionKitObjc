//
//  NSString+EKExtension.h
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

#import <Foundation/Foundation.h>
#import "EKCoreLibsExtension.h"

@interface NSString (EKExtension)

@property (nonatomic, assign, readonly) BOOL isEmpty;
@property (nonatomic, assign, readonly) BOOL isPhoneNumber;
@property (nonatomic, assign, readonly) BOOL isEmail;
@property (nonatomic, copy, nonnull, readonly) NSString *trimed;

- (CGSize)sizeFromFont:(nonnull UIFont *)font;
- (CGSize)sizeFromFont:(nonnull UIFont *)font preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth;
- (CGSize)sizeFromAttributes:(nullable NSDictionary<NSString *, id> *)attributes preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth;
- (nullable NSString *)substringByRange:(EKRange)range;
+ (nonnull NSString *)unique;


@end
