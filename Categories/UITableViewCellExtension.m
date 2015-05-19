//
//  UITableViewCellExtension.m
//  Haioo
//
//  Created by Moch Xiao on 5/10/15.
//  Copyright (c) 2015 Milanoo. All rights reserved.
//

#import "UITableViewCellExtension.h"

@implementation UITableViewCellExtension

@end

#pragma mark - CHXCompressSize

@implementation UITableViewCell (CHXCompressSize)

- (CGFloat)chx_fittingCompressedHeight {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

@end


#pragma mark - CHXConfigureData

@implementation UITableViewCell (CHXConfigureData)

- (void)configureData:(id)data {

}

@end