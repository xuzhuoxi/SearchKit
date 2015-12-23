//
//  SRClassBuilder.m
//  SwiftReflector
//
//  Created by Víctor on 25/8/14.
//  Copyright (c) 2014 Víctor Berga. All rights reserved.
//

#import "SRClassBuilder.h"

@implementation SRClassBuilder

+ (id)createInstanceFromString:(NSString *)className
{
  return [[NSClassFromString(className) alloc] init];
}

@end
