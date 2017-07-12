//
//  NSObject+EKExtension.m
//  Copyright (c) 2014-2016 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSObject+EKExtension.h"
#import "EKCoreLibsExtension.h"

@implementation NSObject (EKExtension)

- (void)ek_associateObject:(nullable id)object forKey:(nonnull const void *)key usingPolicy:(objc_AssociationPolicy)policy {
    EKSetAssociatedObject(self, key, object, policy);
}

- (nullable id)ek_associatedObjectForKey:(nonnull const void *)key {
    return EKGetAssociatedObject(self, key);
}

- (nullable id)ek_performSelector:(nonnull SEL)sel, ... NS_REQUIRES_NIL_TERMINATION {
    NSObject *receiver = [self _receiverForSelector:sel];
    NSMethodSignature *signature = [receiver methodSignatureForSelector:sel];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:receiver];
    [invocation setSelector:sel];
    NSUInteger index = 2;
    
    va_list ap;
    va_start(ap, sel);
    id current = nil;
    do {
        current = va_arg(ap, id);
        if (current) {
            [invocation setArgument:&current atIndex:index];
            ++index;
        }
    } while (nil != current);
    va_end(ap);
    
    [invocation invoke];
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    
    return nil;
}

- (nonnull NSObject *)_receiverForSelector:(nonnull SEL)sel {
    NSObject *receiver = self;
    while (![receiver respondsToSelector:sel]) {
        if ([receiver isKindOfClass:UIResponder.class]) {
            receiver = ((UIResponder *)receiver).nextResponder;
        }
    }
    return receiver;
}

@end
