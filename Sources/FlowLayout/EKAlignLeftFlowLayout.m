//
//  EKAlignLeftFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKAlignLeftFlowLayout.h"

@implementation EKAlignLeftFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    UICollectionViewLayoutAttributes *last;
    for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
        if (element.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        NSInteger count = [self.collectionView numberOfItemsInSection:element.indexPath.section];
        if (count < 2) {
            break;
        }
        // 最后一个并且上一个不在同一行
        if (last && element.indexPath.item == count - 1) {
            if (element.frame.origin.y > CGRectGetMaxY(last.frame)) {
                UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:element.indexPath.section]];
                CGRect newFrame = element.frame;
                newFrame.origin.x = attributes.frame.origin.x;
                element.frame = newFrame;
            }
        }
        last = element;
    }
    
    return layoutAttributes;
}

@end
