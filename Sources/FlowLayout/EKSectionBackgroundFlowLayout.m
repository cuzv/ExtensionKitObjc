//
//  EKSectionBackgroundFlowLayout.m
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import "EKSectionBackgroundFlowLayout.h"

@interface _EKSectionBackgroundLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, strong) UIColor *backgroundColor;
@end

@implementation _EKSectionBackgroundLayoutAttributes
@end


@interface _EKSectionBackgroundCollectionReusableView : UICollectionReusableView
@end

@implementation _EKSectionBackgroundCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:_EKSectionBackgroundLayoutAttributes.class]) {
        self.backgroundColor = ((_EKSectionBackgroundLayoutAttributes *)layoutAttributes).backgroundColor;
    }
}

@end


@interface EKSectionBackgroundFlowLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;
@end

NSString *const EKCollectionElementKindDecoration = @"com.mochxiao.EKCollectionElementKindDecoration";

@implementation EKSectionBackgroundFlowLayout

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self commitInit];
    return self;
}

- (void)commitInit {
    _decorationViewAttrs = [@[] mutableCopy];
    [self registerClass:_EKSectionBackgroundCollectionReusableView.class forDecorationViewOfKind:EKCollectionElementKindDecoration];
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if (![self.collectionView.delegate conformsToProtocol:@protocol(EKSectionBackgroundDelegateFlowLayout)]) {
        return;
    }
    id<EKSectionBackgroundDelegateFlowLayout> delegate = (id<EKSectionBackgroundDelegateFlowLayout>)self.collectionView.delegate;
    NSInteger numberOfSections = self.collectionView.numberOfSections;
    [self.decorationViewAttrs removeAllObjects];
    for (NSInteger section = 0; section < numberOfSections; ++section) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *first = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *last = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!first || !last) {
            continue;
        }
        
        UIEdgeInsets sectionInset = self.sectionInset;
        UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, inset)) {
            sectionInset = inset;
        }
        
        CGRect sectionFrame = CGRectUnion(first.frame, last.frame);
        sectionFrame.origin.x = 0;
        sectionFrame.origin.y -= sectionInset.top;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        _EKSectionBackgroundLayoutAttributes *attributes = [_EKSectionBackgroundLayoutAttributes layoutAttributesForDecorationViewOfKind:EKCollectionElementKindDecoration withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attributes.frame = sectionFrame;
        attributes.zIndex = -1;
        if ([delegate respondsToSelector:@selector(collectionView:layout:backgroundColorForSectionAtIndex:)]) {
            attributes.backgroundColor = [delegate collectionView:self.collectionView layout:self backgroundColorForSectionAtIndex:section];
        }
        [self.decorationViewAttrs addObject:attributes];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *element in self.decorationViewAttrs) {
        if (CGRectIntersectsRect(rect, element.frame)) {
            [layoutAttributes addObject:element];
        }
    }
    return layoutAttributes;
}

@end
