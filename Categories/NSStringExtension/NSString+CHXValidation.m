//
//  NSString+CHXValidation.m
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

#import "NSString+CHXValidation.h"

@implementation NSString (CHXValidation)

- (BOOL)chx_isMatchRegex:(NSString *)regex {
    NSPredicate *phoneNumerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                                   regex];
    return [phoneNumerTest evaluateWithObject:self];
}

// check email
- (BOOL)chx_isValidEmail {
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    //    NSString *emailRegex =
    //    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    //    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    //    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    //    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    //    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    //    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    //    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    return [self chx_isMatchRegex:emailRegex];
}

// Check phone number
- (BOOL)chx_isValidPhoneNumber {
    NSString *phoneNumerRegex = @"^(1[345789])\\d{9}";//@"^(13[\\d]|14[\\d]|15[\\d]|17[\\d]|18[\\d])\\d{8}$";
    return [self chx_isMatchRegex:phoneNumerRegex];
}

// Check password
- (BOOL)chx_isValidPassword {
    NSString *passwordRegex = @"^\\w{6,20}$";
    return [self chx_isMatchRegex:passwordRegex];
}

// Check auth code
- (BOOL)chx_isvalidAuthCode {
    // ^\d{n}$
    NSString *authCodeRegex = @"^\\d{6}$";
    return [self chx_isMatchRegex:authCodeRegex];
}

- (BOOL)chx_isEmpty {
    return nil == self || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
}

- (NSString *)chx_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)chx_filterHTML {
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *html = self;
    
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;

        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        // (you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    
    return html;
    
//    NSArray *components = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    NSMutableArray *componentsToKeep = [NSMutableArray array];
//    
//    for (int i = 0; i < [components count]; i = i + 2) {
//        [componentsToKeep addObject:[components objectAtIndex:i]];
//    }
//    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
//    
//    return plainText;
}

@end
