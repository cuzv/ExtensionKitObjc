//
//  EKSectionBackgroundFlowLayout.h
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKSectionBackgroundDelegateFlowLayout <UICollectionViewDelegateFlowLayout>
@optional
- (nullable UIColor *)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout backgroundColorForSectionAtIndex:(NSInteger)section;
@end

@interface EKSectionBackgroundFlowLayout : UICollectionViewFlowLayout

@end
