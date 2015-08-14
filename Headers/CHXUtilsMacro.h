//
//  CHXUtilsMacro.h
//  Haioo
//
//  Created by Moch Xiao on 5/4/15.
//  Copyright (c) 2015 Milanoo. All rights reserved.
//

#ifndef Haioo_CHXUtilsMacro_h
#define Haioo_CHXUtilsMacro_h

#define iOS6Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_5_1)
#define iOS7Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
#define iOS8Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

#define inch3_5 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 320, 480)))
#define inch4_0 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 320, 568)))
#define inch4_7 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 375, 667)))
#define inch5_5 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 414, 736)))

#endif
