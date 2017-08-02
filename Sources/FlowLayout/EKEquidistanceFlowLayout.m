//
//  EKEquidistanceFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKEquidistanceFlowLayout.h"

@implementation EKEquidistanceFlowLayout

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _spacing = 8;
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    CGFloat contentWidth = self.collectionViewContentSize.width - 2 * self.spacing;
    CGFloat fixedSpacing = self.spacing;
    NSInteger lastSection = 0;
    for (NSInteger index = 0; index < layoutAttributes.count; ++index) {
        if (0 == index) {
            continue;
        }
        UICollectionViewLayoutAttributes *currentAttributes = layoutAttributes[index];
        if (currentAttributes.indexPath.section != lastSection) {
            lastSection = currentAttributes.indexPath.section;
            continue;
        }
        UICollectionViewLayoutAttributes *previewAttributes = layoutAttributes[index - 1];
        CGFloat origin = CGRectGetMaxX(previewAttributes.frame);
        if (origin + fixedSpacing + currentAttributes.frame.size.width < contentWidth) {
            CGRect newFrame = currentAttributes.frame;
            newFrame.origin.x = origin + fixedSpacing;
            currentAttributes.frame = newFrame;
        }
        lastSection = currentAttributes.indexPath.section;
    }
    
    return layoutAttributes;
}

@end
