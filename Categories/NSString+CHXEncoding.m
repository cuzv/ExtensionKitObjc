//
//  NSString+CHXEncoding.m
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

#import "NSString+CHXEncoding.h"

@implementation NSString (CHXEncoding)

- (NSString *)chx_convertAsciiString2UTF8 {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ASCIIEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII);
    NSData *ISOData = [self dataUsingEncoding:ASCIIEncoding];
    NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
    return UTF8String;
}

// Create UTF8 string by ISO string
- (NSString *)chx_convertISOString2UTF8 {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *ISOData = [self dataUsingEncoding:ISOEncoding];
    NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
    return UTF8String;
}

// Create ISO string by UTF-8 string
- (NSString *)chx_convertUTF8String2ISO {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *UTF8Data = [self dataUsingEncoding:UTF8Encoding];
    NSString *ISOString = [[NSString alloc] initWithData:UTF8Data encoding:ISOEncoding];
    return ISOString;
}

- (NSString *)chx_UTF8StringCharacterEscape {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSString *description = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    description = [description stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    description = [[@"\"" stringByAppendingString:description] stringByAppendingString:@"\""];
    NSData *descriptionData = [description dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    description = [NSPropertyListSerialization propertyListWithData:descriptionData options:NSPropertyListMutableContainersAndLeaves format:NULL error:&error];
    if (error) {
        return self;
    }
    
    return description;
}

@end
