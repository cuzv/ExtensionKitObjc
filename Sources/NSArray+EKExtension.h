//
//  NSArray+EKExtension.h
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

@interface NSArray<ObjectType> (EKExtension)

@property (nullable, nonatomic, readonly) ObjectType first;
@property (nullable, nonatomic, readonly) ObjectType second;
@property (nullable, nonatomic, readonly) ObjectType third;
@property (nullable, nonatomic, readonly) ObjectType fourth;
@property (nullable, nonatomic, readonly) ObjectType fifthly;
@property (nullable, nonatomic, readonly) ObjectType sixth;
@property (nullable, nonatomic, readonly) ObjectType seventh;
@property (nullable, nonatomic, readonly) ObjectType eighth;
@property (nullable, nonatomic, readonly) ObjectType ninth;

- (nonnull NSArray *)ek_map:(id _Nonnull (^_Nonnull)(id _Nonnull object))block;
- (nonnull NSArray *)ek_filter:(BOOL (^_Nonnull)(id _Nonnull object))block;
- (nonnull NSArray *)ek_reverse;
- (nonnull NSArray *)ek_unique;
- (nonnull id)ek_reduce:(id _Nonnull (^_Nonnull)(id _Nonnull lhv, id _Nonnull rhv))block;
- (void)ek_each:(void (^_Nonnull)(id _Nonnull object))block;

@end
