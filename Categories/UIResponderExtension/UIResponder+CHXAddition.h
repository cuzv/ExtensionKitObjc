//
//  UIResponder+CHXAddition.h
//  Haioo
//
//  Created by Moch Xiao on 7/24/15.
//  Copyright (c) 2015 Haioo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (CHXAddition)

- (UIResponder *)chx_responderOfClass:(Class)clazz;
/// Code base on Apple's WWDC14 AdvancedCollectionView Session sample
- (BOOL)chx_sendAction:(SEL)action from:(id)sender;

@end
