//
//  UIFont+EKExtension.m
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

#import "UIFont+EKExtension.h"

@implementation UIFont (EKExtension)

+ (instancetype)ek_size8Fixed {
    return [UIFont systemFontOfSize:8];
}

+ (instancetype)ek_size9Fixed {
    return [UIFont systemFontOfSize:9];
}

+ (instancetype)ek_size10Fixed {
    return [UIFont systemFontOfSize:10];
}

+ (instancetype)ek_size11 {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}

+ (instancetype)ek_size12 {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
}

+ (instancetype)ek_size13 {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

+ (instancetype)ek_size14Fixed {
    return [UIFont systemFontOfSize:14];
}

+ (instancetype)ek_size15 {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

+ (instancetype)ek_size16Fixed {
    return [UIFont systemFontOfSize:16];
}

+ (instancetype)ek_size17 {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (instancetype)ek_size17Blod {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

+ (instancetype)ek_size18Fixed {
    return [UIFont systemFontOfSize:18];
}

@end
