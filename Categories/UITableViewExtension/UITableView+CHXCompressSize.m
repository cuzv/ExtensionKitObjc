//
//  UITableView+CHXCompressSize.m
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

#import "UITableView+CHXCompressSize.h"
#import "UITableViewCell+CHXCompressSize.h"
#import "UITableViewHeaderFooterView+CHXCompressSize.h"

@implementation UITableView (CHXCompressSize)

- (CGFloat)chx_heightForReusableCellWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id cell))dataConfiguration {
    return [self chx_heightForReusableCellWithIdentifier:identifier preferredMaxLayoutWidth:CGRectGetWidth(self.bounds) dataConfiguration:dataConfiguration];
}

- (CGFloat)chx_heightForReusableCellWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id cell))dataConfiguration {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        return UITableViewAutomaticDimension;
    }
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    NSAssert(nil != cell, @"Cell must be registered to table view for identifier - %@", identifier);
    
    [cell prepareForReuse];
    dataConfiguration(cell);
    
    // Important
    cell.bounds = CGRectMake(0.0f, 0.0f, preferredMaxLayoutWidth, CGRectGetHeight(cell.bounds));
    
    return [cell chx_fittingCompressedHeight];
}

- (CGFloat)chx_heightForHeaderFooterWithIdentifier:(NSString *)identifier dataConfiguration:(void (^)(id headerFooterView))dataConfiguration {
    return [self chx_heightForHeaderFooterWithIdentifier:identifier preferredMaxLayoutWidth:CGRectGetWidth(self.bounds) dataConfiguration:dataConfiguration];
}

- (CGFloat)chx_heightForHeaderFooterWithIdentifier:(NSString *)identifier preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth dataConfiguration:(void (^)(id headerFooterView))dataConfiguration {
    UITableViewHeaderFooterView *headerFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    NSAssert(nil != headerFooterView, @"UITableViewHeaderFooterView must be registered to table view for identifier - %@", identifier);
    
    [headerFooterView prepareForReuse];
    dataConfiguration(headerFooterView);
    
    // Important
    headerFooterView.bounds = CGRectMake(0.0f, 0.0f, preferredMaxLayoutWidth, CGRectGetHeight(self.bounds));
    
    return [headerFooterView chx_fittingCompressedHeight];

//    /// https://github.com/forkingdog/UITableView-FDTemplateLayoutCell/blob/master/Classes/UITableView%2BFDTemplateLayoutCell.m#L478
//    // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
//    // of growing horizontally, in a flow-layout manner.
//    NSLayoutConstraint *tempWidthConstraint =
//    [NSLayoutConstraint constraintWithItem:headerFooterView.contentView
//                                 attribute:NSLayoutAttributeWidth
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                  constant:preferredMaxLayoutWidth];
//    [headerFooterView.contentView addConstraint:tempWidthConstraint];
//    // Auto layout engine does its math
//    CGFloat fittingSizeHeight = [headerFooterView chx_fittingCompressedHeight];
//
////    [headerFooterView.contentView removeConstraint:tempWidthConstraint];
//    
//    return fittingSizeHeight;
}


@end
