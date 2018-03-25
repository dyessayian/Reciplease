//
//  RCPAppManager.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/21/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPAppManager.h"

@implementation RCPAppManager

+ (instancetype)sharedInstance {
    static RCPAppManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    }); return sharedInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        //Initialization
        self.appColorsArray = [NSMutableArray arrayWithObjects:[UIColor RCPBlueColor], [UIColor RCPGreenColor], [UIColor RCPPeachColor], [UIColor RCPYellowColor], [UIColor RCPTurquoiseColor], [UIColor RCPGoldColor], [UIColor RCPLightBrownColor], nil];
        self.measurementTypesArray = [NSMutableArray arrayWithObjects:@"cup", @"clove", @"dash", @"drop", @"fl oz", @"gallon", @"gram", @"kg", @"lb", @"liter", @"mg", @"oz", @"piece", @"pinch", @"pint", @"quart", @"sheet", @"shot", @"tbsp", @"tsp", nil];
    } return self;
}

#pragma mark - Measurement Types Enumeration
- (NSString*)stringWithEnum:(NSUInteger)enumVal {
    return [self.measurementTypesArray objectAtIndex:enumVal];
}

- (NSUInteger)enumFromString:(NSString*)strVal default:(NSUInteger)def {
    NSUInteger n = [self.measurementTypesArray indexOfObject:strVal];
    if(n == NSNotFound)
        n = def;
    return n;
}

- (NSUInteger)enumFromString:(NSString*)strVal {
    return [self enumFromString:strVal default:0];
}

#pragma mark - Other
- (NSString*) retrievePathForFilenameWithString:(NSString*)filename {
    //Helper method to retrieve the path for a given filename.
    if (filename.length == 0){
        return @""; //If no filename was sent, can't find a path.
    }
    else {
        //First, check if file was built into the project.
        // Need to split the filename into pieces for the name and extension.
        NSString *nameOnly = [filename stringByDeletingPathExtension];
        NSString *extensionOnly = [filename pathExtension];
        NSString *localPathOfFile = [[NSBundle mainBundle] pathForResource:nameOnly ofType:extensionOnly];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:localPathOfFile]){
            return localPathOfFile;
        }
        
        //Since file doesn't exist locally, check the document directory for the file.
        NSString *realpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:filename];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:realpath];
        if (fileExists){
            return realpath;
        }
        
        //Final attempt: check the document directory for the file after replacing any "%20" from the name.  This can occur when receiving a path from a webservice.
        NSString *filePathWithoutPercents = [filename stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        NSString *realpath2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:filePathWithoutPercents];
        BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:realpath2];
        if (fileExists2){
            return realpath2;
        }
        
        return @""; //Reached end of search and couldn't find the file in main bundle or in the document directory.
    }
}


@end
