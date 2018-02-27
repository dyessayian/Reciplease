//
//  RCPRecipeIngredient+CoreDataClass.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/19/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCPIngredient, RCPRecipe;

NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeIngredient : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "RCPRecipeIngredient+CoreDataProperties.h"
