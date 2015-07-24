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

@end
