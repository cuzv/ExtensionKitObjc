//
//  UITableView+CHXResizeTableHeaderFooterView.m
//  ResizeTableHeaderView
//
//  Created by Moch Xiao on 8/19/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "UITableView+CHXResizeTableHeaderFooterView.h"

@implementation UITableView (CHXResizeTableHeaderFooterView)

- (void)chx_sizeHeaderToFit {
    UIView *headerView = self.tableHeaderView;
    if (!headerView) {
        return;
    }
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    headerView.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.tableHeaderView = headerView;
}

- (void)chx_sizeFooterToFit {
    UIView *footerView = self.tableFooterView;
    if (!footerView) {
        return;
    }
    
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    [footerView setNeedsLayout];
    [footerView layoutIfNeeded];
    
    CGSize size = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect frame = footerView.frame;
    frame.size.height = size.height;
    footerView.frame = frame;
    
    self.tableFooterView = footerView;
}

@end
