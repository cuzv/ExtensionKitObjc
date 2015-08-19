//
//  UITableView+CHXResizeTableHeaderView.m
//  ResizeTableHeaderView
//
//  Created by Moch Xiao on 8/19/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "UITableView+CHXResizeTableHeaderView.h"

@implementation UITableView (CHXResizeTableHeaderView)

- (void)chx_sizeHeaderToFit {
    UIView *headerView = self.tableHeaderView;
    if (!headerView) {
        return;
    }
    
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    headerView.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.tableHeaderView = headerView;
}

@end
