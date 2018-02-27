//
//  RCPRecipeImage+CoreDataClass.m
//  Reciplease
//
//  Created by Daniel Yessayian on 10/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//
//

#import "RCPRecipeImage+CoreDataClass.h"
#import "RCPAppManager.h"

@implementation RCPRecipeImage

-(void)prepareForDeletion {
    
    //NSLog(@"%@: prepareForDeletion.  Deleting any local files associated to this object.", self.class);
    
    NSString *pathForFile = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:self.recipeImageName];
    if (pathForFile.length > 0){
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:pathForFile error:&error];
        if (success) {
            //Deleted file successfully.
            //NSLog(@"✅: Deleted file!");
        } else {
            //Error deleting file.
            //NSLog(@"❌: Error deleting file from device: %@", [error localizedDescription]);
        }
    }
}

@end
