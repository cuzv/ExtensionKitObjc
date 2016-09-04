//
//  NSString+EKExtension.m
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

#import "NSString+EKExtension.h"

@implementation NSString (EKExtension)

- (BOOL)isEmpty {
    return self.length == 0;
}

- (BOOL)isPhoneNumber {
    return _EKStringMatch(self, @"^(1[345789])\\d{9}");
}

- (BOOL)isEmail {
    return _EKStringMatch(self, @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");
}

BOOL _EKStringMatch(NSString *_Nonnull str, NSString *_Nonnull pattern) {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern] evaluateWithObject:str];
}

- (NSString *)trimed {
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (nullable NSString *)substringByRange:(EKRange)range {
    if (range.end > self.length) {
        return nil;
    }
    return [self substringWithRange:(NSRange){range.start, range.end - range.start}];
}

- (CGSize)sizeFromFont:(nonnull UIFont *)font {
    return [self sizeFromFont:font preferredMaxLayoutWidth:0];
}

- (CGSize)sizeFromFont:(nonnull UIFont *)font preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    return [self sizeFromAttributes:@{NSFontAttributeName: font} preferredMaxLayoutWidth:preferredMaxLayoutWidth];
}

- (CGSize)sizeFromAttributes:(nullable NSDictionary<NSString *, id> *)attributes preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    preferredMaxLayoutWidth = preferredMaxLayoutWidth > 0 ? preferredMaxLayoutWidth : CGRectGetWidth(UIScreen.mainScreen.bounds);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    return [self boundingRectWithSize:CGSizeMake(preferredMaxLayoutWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
}

+ (nonnull NSString *)unique {
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
