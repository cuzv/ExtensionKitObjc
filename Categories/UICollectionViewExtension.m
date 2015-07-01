//
//  UICollectionViewExtension.m
//  Haioo
//
//  Created by Moch Xiao on 6/30/15.
//  Copyright (c) 2015 Haioo. All rights reserved.
//

#import "UICollectionViewExtension.h"

@implementation UICollectionViewExtension

@end


#pragma mark - CHXCompressSize

@implementation UICollectionView (CHXCompressSize)

- (CGSize)chx_sizeForReusableCellWithClass:(Class)clazz dataConfiguration:(void (^)(id cell))dataConfiguration {
    UICollectionViewCell *cell = [self chx_associatedObjectForKey:(__bridge void *)(NSStringFromClass(clazz))];
    if (!cell) {
        cell = [[clazz alloc] initWithFrame:CGRectZero];
        [self chx_associateObject:cell forKey:(__bridge void *)(NSStringFromClass(clazz))];
    }
    
    [cell prepareForReuse];
    dataConfiguration(cell);
    
    // Important
//    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}


@end