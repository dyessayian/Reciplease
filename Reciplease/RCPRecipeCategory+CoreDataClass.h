//
//  RCPRecipeCategory+CoreDataClass.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/19/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCPRecipe;

NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeCategory : NSManagedObject

+(void)buildRCPRecipeCategoryWithDictionary:(NSDictionary*)categoryDict;

@end

NS_ASSUME_NONNULL_END

#import "RCPRecipeCategory+CoreDataProperties.h"
