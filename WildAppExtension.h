//
//  WildAppExtension.h
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 5/2/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#ifndef WildAppExtensionRunner_WildAppExtension_h
#define WildAppExtensionRunner_WildAppExtension_h

// ATTENTION:
// THIS LIBRARY HAS OVERRIDE SOME METHOD:
// UILabel(setBounds:)
// NSDictionary(descriptionWithLocale:indent:) only when `BETTER_DESCRIPTION` defined
// NSLog only when `BETTER_NSLOG` defined

// If you wanna use better NSLog, define `BETTER_NSLOG` before import this header file
// If you wanna use better description on your terminal, define `BETTER_DESCRIPTION` before import this header file

// Headers
#import "CHXFunctionDefine.h"
#import "CHXFontDefine.h"
#import "CHXColorDefine.h"
#import "CHXUtilsMacro.h"

// Categories
#import "CAAnimation+CHXMaker.h"
#import "CADisplayLink+CHXAddition.h"
#import "NSTimer+CHXAddition.h"
#import "NSData+CHXJSON.h"
#import "NSData+CHXEncoding.h"
#import "NSDate+CHXAddition.h"
#import "NSDateFormatter+CHXAddition.h"
#import "NSArray+CHXFunctionalProgramming.h"
#import "NSArray+CHXAddition.h"
#import "NSDictionary+CHXURLPath.h"
#import "NSDictionary+CHXJSON.h"
#import "NSDictionary+CHXDescription.h"
#import "NSString+CHXJSON.h"
#import "NSString+CHXTextSize.h"
#import "NSString+CHXValidation.h"
#import "NSString+CHXEncoding.h"
#import "NSString+CHXTimeStamp.h"
#import "NSObject+CHXORM.h"
#import "NSObject+CHXAssociatedObject.h"
#import "UIAlertView+CHXMaker.h"
#import "UIButton+CHXIndicatorAnimation.h"
#import "UIButton+CHXImageAlignment.h"
#import "UIButton+CHXResponseRegion.h"
#import "UIButton+CHXControlState.h"
#import "UIColor+CHXRandomColor.h"
#import "UIImage+CHXRepresention.h"
#import "UIImage+CHXMaker.h"
#import "UIImage+CHXLoad.h"
#import "UILabel+CHXMultiLineAutoLayout.h"
#import "UICollectionView+CHXCompressSize.h"
#import "UICollectionViewCell+CHXConfigureData.h"
#import "UITableView+CHXCompressSize.h"
#import "UITableView+CHXResizeTableHeaderView.h"
#import "UITableViewCell+CHXCompressSize.h"
#import "UITableViewCell+CHXConfigureData.h"
#import "UITableViewHeaderFooterView+CHXCompressSize.h"
#import "UINavigationBar+CHXIndicatorAnimation.h"
#import "UIViewController+CHXNavigationActivityIndicatorAnimation.h"
#import "UIViewController+CHXDebugging.h"
#import "UIViewController+CHXStack.h"
#import "UIViewController+CHXNavigation.h"
#import "UIScrollView+CHXAccessor.h"
#import "UIView+CHXAccessor.h"
#import "UIView+CHXArcRotationAnimation.h"
#import "UIView+CHXShakeAnimation.h"
#import "UIView+CHXPingPangAnimation.h"
#import "UIView+CHXActivityIndicatorAnimation.h"
#import "UIView+CHXBorderLine.h"
#import "UIView+CHXCorner.h"
#import "UIView+CHXResponderViewController.h"
#import "UIView+CHXBlur.h"
#import "UIView+CHXDebugging.h"
#import "UIResponder+CHXAddition.h"

// Helper
#import "CHXGlobalServices.h"
#import "CHXArrayDataSource.h"
#import "CHXUserDefaults.h"

// Macro
#import "CHXColorDefine.h"
#import "CHXFontDefine.h"
#import "CHXFunctionDefine.h"
#import "CHXUtilsMacro.h"

#endif
