//
//  CHXFunctionDefine.h
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 4/24/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#ifndef WildAppExtensionRunner_CHXFunctionDefine_h
#define WildAppExtensionRunner_CHXFunctionDefine_h

#ifdef BETTER_NSRLOG

//  Better NSLog
#if DEBUG

#define NSLog(FORMAT, ...) \
    do { \
        fprintf(stderr,"%s: %d: %s\n", \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
        __LINE__, \
        [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]); \
    } while(0)
#else
    #define NSLog(FORMAT, ...) NSLog(@"")
#endif

#endif

// hack_description
#define hack_object_description    \
+ (void)load {                     \
    chx_swizzleInstanceMethod([self class], @selector(description), @selector(hack_description));       \
    chx_swizzleInstanceMethod([self class], @selector(debugDescription), @selector(hack_description));  \
}                           \
                            \
- (NSString *)hack_description {                    \
    NSString *original = [self hack_description];   \
    return [@"hacked description:" stringByAppendingString:original];       \
}                                                                           \
                                                                            \
- (NSString *)description {                                                 \
    return [self chx_toString];                                             \
}                                                                           \
                                                                            \
- (NSString *)debugDescription {                                            \
    return [self chx_toString];                                             \
}

#endif
