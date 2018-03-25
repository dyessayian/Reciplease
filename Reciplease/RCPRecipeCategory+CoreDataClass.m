//
//  RCPRecipeCategory+CoreDataClass.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/19/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeCategory+CoreDataClass.h"
#import "RCPRecipe+CoreDataClass.h"

@implementation RCPRecipeCategory

+(void)buildRCPRecipeCategoryWithDictionary:(NSDictionary*)categoryDict {
    
    if ([categoryDict isKindOfClass:[NSDictionary class]]){
        
        NSNumber *categoryIDFromDict = [categoryDict valueForKey:@"categoryID"];
        NSString *categoryNameStringFromDict = [categoryDict valueForKey:@"categoryName"];
        NSString *imageNameFromDict = [categoryDict valueForKey:@"imageName"];
        
        RCPRecipeCategory *category = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryID" withValue:categoryIDFromDict];
        
        if (!category){
            //NSLog(@"✳️: Creating category: %@", categoryNameStringFromDict);
            category = [RCPRecipeCategory MR_createEntity];
        }
        else {
            //NSLog(@"♻️: Updating category: %@", categoryNameStringFromDict);
        }
        
        category.categoryID = categoryIDFromDict ? categoryIDFromDict : @(-1);
        category.categoryName = categoryNameStringFromDict.length > 0 ? categoryNameStringFromDict : @"";
        category.imageName = imageNameFromDict.length > 0 ? imageNameFromDict : @"";
    }
    else {
        //NSLog(@"Recipe category dictionary not received in proper format.");
    }
}

@end
