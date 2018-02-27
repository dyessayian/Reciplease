//
//  NSDateFormatter+RCPDateFormatter.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/26/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "NSDateFormatter+RCPDateFormatter.h"

@implementation NSDateFormatter (RCPDateFormatter)

+ (NSDateFormatter *)imageNameTimestampFormatter {
    static NSDateFormatter *imageNameDF = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dateFormat = @"yyyy_MM_dd_HH:mm:ss";
        imageNameDF = [[NSDateFormatter alloc] init];
        [imageNameDF setDateFormat:dateFormat];
    });
    return imageNameDF;
}

@end
