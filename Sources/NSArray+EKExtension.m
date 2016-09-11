//
//  NSArray+EKExtension.m
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

#import "NSArray+EKExtension.h"

@implementation NSArray (EKExtension)

- (id)ek_first {
    return self.firstObject;
}

- (id)ek_second {
    if (self.count > 1) {
        return self[1];
    }
    return nil;
}

- (id)ek_third {
    if (self.count > 2) {
        return self[2];
    }
    return nil;
}

- (id)ek_fourth {
    if (self.count > 3) {
        return self[3];
    }
    return nil;
}

- (id)ek_fifthly {
    if (self.count > 4) {
        return self[4];
    }
    return nil;
}

- (id)ek_sixth {
    if (self.count > 5) {
        return self[5];
    }
    return nil;
}

- (id)ek_seventh {
    if (self.count > 6) {
        return self[6];
    }
    return nil;
}

- (id)ek_eighth {
    if (self.count > 7) {
        return self[7];
    }
    return nil;
}

- (id)ek_ninth {
    if (self.count > 8) {
        return self[8];
    }
    return nil;
}

- (nonnull NSArray *)ek_map:(id _Nonnull (^_Nonnull)(id _Nonnull object))block {
    if (![self count]) {
        return self;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id obj in self) {
        [resultArray addObject:block(obj)];
    }
    
    return resultArray;
}
- (nonnull NSArray *)ek_filter:(BOOL (^_Nonnull)(id _Nonnull object))block {
    if (![self count]) {
        return self;
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (id obj in self) {
        if (block(obj)) {
            [resultArray addObject:obj];
        }
    }
    
    return resultArray;
}

- (nonnull NSArray *)ek_reverse {
    if (![self count]) {
        return self;
    }
    
    return [self reverseObjectEnumerator].allObjects;
}

// http://nshipster.cn/kvc-collection-operators/
- (nonnull NSArray *)ek_unique {
    if (![self count]) {
        return self;
    }
    
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

- (nonnull id)ek_reduce:(id _Nonnull (^_Nonnull)(id _Nonnull lhv, id _Nonnull rhv))block {
    if (![self count]) {
        return self;
    }
    
    id result = [self objectAtIndex:0];
    for(NSUInteger index = 1; index < [self count]; index++) {
        result = block(result, [self objectAtIndex:index]);
    }
    
    return result;
}

- (void)ek_each:(void (^_Nonnull)(id _Nonnull object))block {
    if (![self count]) {
        return;
    }
    
    for (id obj in self) {
        block(obj);
    }
}



@end
