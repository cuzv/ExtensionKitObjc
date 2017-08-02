//
//  EKStickyHeadersFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKStickyHeadersFlowLayout.h"

@implementation EKStickyHeadersFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableIndexSet *headersNeedingLayout = [NSMutableIndexSet new];
    for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
        if ([element.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [headersNeedingLayout addIndex:element.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
        if (element.representedElementCategory == UICollectionElementCategoryCell) {
            [headersNeedingLayout removeIndex:element.indexPath.section];
        }
    }
    [headersNeedingLayout enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attributes) {
            [layoutAttributes addObject:attributes];
        }
    }];
    for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
        // 剔除 header
        if ([element.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            continue;
        }
        
        NSInteger section = element.indexPath.section;
        NSInteger count = [self.collectionView numberOfItemsInSection:section];
        if (!count) {
            break;
        }
        UICollectionViewLayoutAttributes *attributesForFirstItemInSection = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *attributesForLastItemInSection = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:count - 1 inSection:section]];
        CGRect frame = element.frame;
        CGFloat offset = self.collectionView.contentOffset.y + self.collectionView.contentInset.top;
        
        /* The header should never go further up than one-header-height above
         the upper bounds of the first cell in the current section */
        CGFloat minY = CGRectGetMinY(attributesForFirstItemInSection.frame) - CGRectGetHeight(frame);
        /* The header should never go further down than one-header-height above
         the lower bounds of the last cell in the section */
        CGFloat maxY = CGRectGetMaxY(attributesForLastItemInSection.frame) - CGRectGetHeight(frame);
        /* If it doesn't break either of those two rules then it should be
         positioned using the y value of the content offset */
        CGFloat y = MIN(MAX(offset, minY), maxY);
        
        frame.origin.y = y;
        element.frame = frame;
        element.zIndex = 1;
    }
    return layoutAttributes;
}

@end
