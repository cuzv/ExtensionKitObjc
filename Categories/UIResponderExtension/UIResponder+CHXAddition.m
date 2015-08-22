//
//  UIResponder+CHXAddition.m
//  Haioo
//
//  Created by Moch Xiao on 7/24/15.
//  Copyright (c) 2015 Haioo. All rights reserved.
//

#import "UIResponder+CHXAddition.h"

@implementation UIResponder (CHXAddition)

- (UIResponder *)chx_responderOfClass:(Class)clazz {
    UIResponder *responder = self;
    
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:clazz]) {
            return responder;
        }
    }
    
    return nil;
}

- (BOOL)chx_sendAction:(SEL)action from:(id)sender {
    // Get the target in the responder chain
    id target = sender;
    
    while (target && ![target canPerformAction:action withSender:sender]) {
        target = [target nextResponder];
    }
    
    if (!target)
        return NO;
    
    return [[UIApplication sharedApplication] sendAction:action to:target from:sender forEvent:nil];
}


@end
