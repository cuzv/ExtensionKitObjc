//
//  UITableView+CHXResizeTableHeaderFooterView.h
//  ResizeTableHeaderView
//
//  Created by Moch Xiao on 8/19/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CHXResizeTableHeaderFooterView)

/// Resize tableView header
/// You should call `layoutSubviews` or `layoutIfNeeded` after you called this method when you use iOS7
/// You should given your header view a bounds when you use iOS7
- (void)chx_sizeHeaderToFit;

/// Resize tableView footer
/// You should call `layoutSubviews` or `layoutIfNeeded` after you called this method when you use iOS7
/// You should given your footer view a bounds when you use iOS7
- (void)chx_sizeFooterToFit;

@end
