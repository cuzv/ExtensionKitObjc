//
//  UITableView+CHXCompressSize.h
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

#import <UIKit/UIKit.h>

@interface UITableView (CHXCompressSize)

/// 计算 UITableViewCell 自动布局的高度，默认计算宽度是等于 UITableView 的宽度
- (CGFloat)chx_heightForReusableCellWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id cell))dataConfiguration;
/// 计算 UITableViewCell 自动布局的高度，指定计算尺寸时候的宽度
- (CGFloat)chx_heightForReusableCellWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id cell))dataConfiguration;

/// 计算 UITableViewHeaderFooterView 自动布局的高度，默认计算宽度是等于 UITableView 的宽度
- (CGFloat)chx_heightForHeaderFooterWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id headerFooterView))dataConfiguration;
/// 计算 UITableViewHeaderFooterView 自动布局的高度，指定计算尺寸时候的宽度
- (CGFloat)chx_heightForHeaderFooterWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id headerFooterView))dataConfiguration;

@end
