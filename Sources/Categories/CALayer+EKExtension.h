//
//  CALayer+EKExtension.h
//  ExtensionKitObjc
//
//  Created by Moch Xiao on 2/23/17.
//  Copyright © 2017 Moch Xiao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (EKExtension)

#pragma mark - Frame Accessor

@property (nonatomic, assign) CGPoint ek_origin;
@property (nonatomic, assign) CGSize ek_size;
@property (nonatomic, assign) CGFloat ek_minX;
@property (nonatomic, assign) CGFloat ek_midX;
@property (nonatomic, assign) CGFloat ek_maxX;
@property (nonatomic, assign) CGFloat ek_minY;
@property (nonatomic, assign) CGFloat ek_midY;
@property (nonatomic, assign) CGFloat ek_maxY;
@property (nonatomic, assign) CGFloat ek_width;
@property (nonatomic, assign) CGFloat ek_height;

@property (nonatomic, assign) CGFloat ek_left;
@property (nonatomic, assign) CGFloat ek_right;
@property (nonatomic, assign) CGFloat ek_top;
@property (nonatomic, assign) CGFloat ek_bottom;

@property (nonatomic, assign) CGFloat ek_centerX;
@property (nonatomic, assign) CGFloat ek_centerY;
@property (nonatomic, assign) CGPoint ek_center;

#pragma mark - 

- (nullable UIImage *)snapshotImage;
- (nullable NSData *)snapshotPDF;
- (void)setLayerShadow:(nonnull UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;
- (void)removeAllSublayers;

@end
