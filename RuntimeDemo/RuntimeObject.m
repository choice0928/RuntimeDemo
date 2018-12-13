//
//  RuntimeObject.m
//  RuntimeDemo
//
//  Created by 王鑫 on 2018/12/13.
//  Copyright © 2018 wangxin. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>

@implementation RuntimeObject

void testImp (void) {
    
    NSLog(@"test invoke");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    //如果调用的使我们的test方法
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod");
        
        //动态添加test方法实现
        class_addMethod(self, @selector(test), testImp, "v@:");
        
        return YES;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"forwardingTargetForSelector");
    //返回nil,这样就能走到第三个步骤
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
             
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSLog(@"forwardInvocation");
}


@end
