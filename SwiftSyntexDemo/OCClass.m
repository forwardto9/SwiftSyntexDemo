//
//  OCClass.m
//  SwiftSyntexDemo
//
//  Created by uwei on 10/11/2016.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "OCClass.h"

@implementation OCClass
- (void)showInfo:(NSString *)name {
    NSLog(@"%@", name);
}
@end
NSString * getInfo(const char *params) {
    return [NSString stringWithCString:params encoding:NSUTF8StringEncoding];
}
