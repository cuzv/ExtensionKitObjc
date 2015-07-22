//
//  NSString+CHXEncoding.h
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

#import <Foundation/Foundation.h>

@interface NSString (CHXEncoding)

/**
 *  Create UTF-8 string by ASCII string
 *
 *  @return ASCII string
 */
- (NSString *)chx_convertAsciiString2UTF8;

/**
 *  Create UTF-8 string by ISO string
 *
 *  @return UTF-8 string
 */
- (NSString *)chx_convertISOString2UTF8;

/**
 *  Create ISO string by UTF-8 string
 *
 *  @return ISO string
 */
- (NSString *)chx_convertUTF8String2ISO;

/**
 *  转义 UTF-8 字符串字符，让其适合在终端输出中文
 *
 *  @return UTF-8 转义字符串
 */
- (NSString *)chx_UTF8StringCharacterEscape;


@end
