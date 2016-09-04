//
//  UIColor+EKExtension.m
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

#import "UIColor+EKExtension.h"
#import "EKCoreLibsExtension.h"

@implementation UIColor (EKExtension)

+ (nullable instancetype)ek_random {
    return [UIColor colorWithRed:EKRandomIn(EKRangeMake(0, 255)) / 255.0f green:EKRandomIn(EKRangeMake(0, 255)) / 255.0f blue:EKRandomIn(EKRangeMake(0, 255)) / 255.0f alpha:1];
}

UIColor *_Nullable EKColorMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor ek_colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (nullable instancetype)ek_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (nullable instancetype)ek_colorWithHex:(nonnull NSString *)hex alpah:(CGFloat)alpha {
    // Convert hex string to an integer
    unsigned int hexint = 0;

    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    // Create color object, specifying alpha
    
    return [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16)) / 255.0f
                           green:((CGFloat) ((hexint & 0xFF00) >> 8)) / 255.0f
                            blue:((CGFloat) (hexint & 0xFF)) / 255.0f
                           alpha:alpha];
}

UIColor *_Nullable EKColorFrom(NSString *_Nonnull hex, CGFloat alpha) {
    return [UIColor ek_colorWithHex:hex alpah:alpha];
}

+ (nullable instancetype)ek_tint {
    // 3, 122, 255, 100
    return EKColorFrom(@"037AFF", 1);
}

+ (nullable instancetype)ek_separator {
    // 200, 199, 204, 100
    return EKColorFrom(@"C8C7CC", 1);
}

+ (nullable instancetype)ek_groupedBackground {
    // 239, 239, 244, 100
    return EKColorFrom(@"EFEFF4", 1);
}

+ (nullable instancetype)ek_activityBackground {
    // 248, 248, 248, 60
    return EKColorFrom(@"F8F8F8", 1);
}

+ (nullable instancetype)ek_disclosureIndicator {
    return EKColorFrom(@"C7C7CC", 1);
}

+ (nullable instancetype)ek_naviTitle {
    // 3, 3, 3, 100
    return EKColorFrom(@"030303", 1);
}

+ (nullable instancetype)ek_subTitle {
    // 144, 144, 148, 100
    return EKColorFrom(@"909094", 1);
}

+ (nullable instancetype)ek_placeholder {
    // 200, 200, 205, 100
    return EKColorFrom(@"C8C8CD", 1);
}


@end
