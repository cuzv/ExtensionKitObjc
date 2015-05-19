//
//  UITableViewCellExtension.h
//  Haioo
//
//  Created by Moch Xiao on 5/10/15.
//  Copyright (c) 2015 Milanoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCellExtension : NSObject

@end

#pragma mark - CHXCompressSize

@interface UITableViewCell (CHXCompressSize)

- (CGFloat)chx_fittingCompressedHeight;

@end

#pragma mark - CHXConfigureData

@interface UITableViewCell (CHXConfigureData)

- (void)configureData:(id)data;

@end