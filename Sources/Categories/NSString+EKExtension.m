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
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (EKExtension)

- (BOOL)ek_isEmpty {
    return self.length == 0;
}

- (BOOL)ek_isPhoneNumber {
    return _EKStringMatch(self, @"^(1[345789])\\d{9}");
}

- (BOOL)ek_isEmail {
    return _EKStringMatch(self, @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");
}

BOOL _EKStringMatch(NSString *_Nonnull str, NSString *_Nonnull pattern) {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern] evaluateWithObject:str];
}

- (NSString *)ek_trimed {
    return [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

- (nullable NSString *)ek_substringByRange:(EKRange)range {
    if (range.end > self.length) {
        return nil;
    }
    return [self substringWithRange:(NSRange){range.start, range.end - range.start}];
}

- (CGSize)ek_sizeFromFont:(nonnull UIFont *)font {
    return [self ek_sizeFromFont:font preferredMaxLayoutWidth:0];
}

- (CGSize)ek_sizeFromFont:(nonnull UIFont *)font preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    return [self ek_sizeFromAttributes:@{NSFontAttributeName: font} preferredMaxLayoutWidth:preferredMaxLayoutWidth];
}

- (CGSize)ek_sizeFromAttributes:(nullable NSDictionary<NSString *, id> *)attributes preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    preferredMaxLayoutWidth = preferredMaxLayoutWidth > 0 ? preferredMaxLayoutWidth : CGRectGetWidth(UIScreen.mainScreen.bounds);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    return [self boundingRectWithSize:CGSizeMake(preferredMaxLayoutWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
}

+ (nonnull NSString *)ek_unique {
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (NSString *)ek_md5 {
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

@end
