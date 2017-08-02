//
//  EKStretchyHeaderFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKStretchyHeaderFlowLayout.h"

@interface EKStretchyHeaderFlowLayout ()
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttributes;
@end

@implementation EKStretchyHeaderFlowLayout

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _topDockHeight = 0;
    _coefficient = 2.4;
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    UIEdgeInsets insets = self.collectionView.contentInset;
    CGPoint offset = self.collectionView.contentOffset;
    CGFloat minY = -insets.top;
    if (offset.y < minY) {
        CGFloat deltaY = fabs(offset.y - minY);
        for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
            if (0 == element.indexPath.section) {
                if (element.representedElementKind == UICollectionElementKindSectionHeader) {
                    CGRect frame = element.frame;
                    CGFloat referenceHeight = self._stretchyHeaderReferenceSize.height;
                    CGFloat newHeight = MAX(minY, referenceHeight + deltaY);
                    if (newHeight > self.coefficient * referenceHeight) {
                        newHeight = self.coefficient * referenceHeight;
                    }
                    frame.size.height = newHeight;
                    frame.origin.y = CGRectGetMinY(frame) - deltaY;
                    element.frame = frame;
                    break;
                }
            }
        }
        if (self.scrollDownAction) {
            self.scrollDownAction(deltaY);
        }
    } else {
        CGFloat referenceHeight = self._stretchyHeaderReferenceSize.height;
        CGFloat coverHeight = referenceHeight - self.topDockHeight - insets.top;
        if (offset.y > coverHeight) {
            CGFloat deltaY = fabs(offset.y);
            for (UICollectionViewLayoutAttributes *element in layoutAttributes.mutableCopy) {
                if (0 == element.indexPath.section) {
                    if (element.representedElementKind == UICollectionElementKindSectionHeader) {
                        CGRect frame = element.frame;
                        frame.origin.y = deltaY - coverHeight;
                        element.frame = frame;
                        element.zIndex = 1;
                        self.headerAttributes = element;
                    } else {
                        if (self.headerAttributes) {
                            CGRect frame = self.headerAttributes.frame;
                            frame.origin.y = deltaY - coverHeight;
                            self.headerAttributes.frame = frame;
                            [layoutAttributes addObject:self.headerAttributes];
                        }
                    }
                }
            }
            if (self.scrollUpAction) {
                self.scrollUpAction(1.0);
            }
        } else {
            if (self.scrollUpAction) {
                self.scrollUpAction(1.0 - (coverHeight - offset.y) / coverHeight);
            }
        }
    }
    
    return layoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)_stretchyHeaderReferenceSize {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:0];
    }
    return self.headerReferenceSize;
}

@end
