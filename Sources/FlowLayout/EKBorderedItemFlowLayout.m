//
//  EKBorderedItemFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKBorderedItemFlowLayout.h"

@interface EKBorderedItemFlowLayoutAttributes ()
@property (nonatomic, assign, readwrite) BOOL nearTop;
@property (nonatomic, assign, readwrite) BOOL nearLeft;
@end

@implementation EKBorderedItemFlowLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    id copy = [super copyWithZone:zone];
    if ([copy isKindOfClass:EKBorderedItemFlowLayoutAttributes.class]) {
        EKBorderedItemFlowLayoutAttributes *_copy = (EKBorderedItemFlowLayoutAttributes *)copy;
        _copy->_nearTop = _nearTop;
        _copy->_nearLeft = _nearLeft;
    }
    return copy;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:EKBorderedItemFlowLayoutAttributes.class]) {
        return NO;
    }
    EKBorderedItemFlowLayoutAttributes *other = (EKBorderedItemFlowLayoutAttributes *)object;
    return other.nearLeft == self.nearLeft && other.nearTop == self.nearTop && [super isEqual:object];
}

@end


@implementation EKBorderedItemFlowLayout

+ (Class)layoutAttributesClass {
    return EKBorderedItemFlowLayoutAttributes.class;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *element in layoutAttributes) {
        [self _adjustLayoutAttributes:element];
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self _adjustLayoutAttributes:layoutAttributes];
    return layoutAttributes;
}

- (void)_adjustLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *first = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:layoutAttributes.indexPath.section]];
    if (![first isKindOfClass:EKBorderedItemFlowLayoutAttributes.class]) {
        return;
    }
    EKBorderedItemFlowLayoutAttributes *_first = (EKBorderedItemFlowLayoutAttributes *)first;
    _first.nearTop = CGRectGetMidY(first.frame) == CGRectGetMinY(layoutAttributes.frame);
    _first.nearLeft = CGRectGetMidX(first.frame) == CGRectGetMidX(layoutAttributes.frame);
}

@end
