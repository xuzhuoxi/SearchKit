//
//  SRClassBuilder.h
//  SwiftReflector
//
//  Created by Víctor on 25/8/14.
//  Copyright (c) 2014 Víctor Berga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRClassBuilder : NSObject

+ (id)createInstanceFromString:(NSString *)className;

@end
