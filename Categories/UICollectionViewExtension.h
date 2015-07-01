//
//  UICollectionViewExtension.h
//  Haioo
//
//  Created by Moch Xiao on 6/30/15.
//  Copyright (c) 2015 Haioo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICollectionViewExtension : NSObject

@end

#pragma mark - CHXCompressSize

@interface UICollectionView (CHXCompressSize)
- (CGSize)chx_sizeForReusableCellWithClass:(Class)clazz dataConfiguration:(void (^)(id cell))dataConfiguration;
@end


