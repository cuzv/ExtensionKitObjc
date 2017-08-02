//
//  EKStretchyHeaderFlowLayout.h
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKStretchyHeaderFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat topDockHeight; ///< default: 0
@property (nonatomic, assign) CGFloat coefficient; ///< default: 2.4
@property (nonatomic, copy) void (^scrollUpAction)(CGFloat progress);
@property (nonatomic, copy) void (^scrollDownAction)(CGFloat translation);

@end
