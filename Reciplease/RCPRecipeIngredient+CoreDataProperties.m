//
//  RCPRecipeIngredient+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/29/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeIngredient+CoreDataProperties.h"

@implementation RCPRecipeIngredient (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeIngredient *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipeIngredient"];
}

@dynamic ingredientMeasurement;
@dynamic ingredientQuantity;
@dynamic ingredientNumber;
@dynamic ingredient;
@dynamic recipe;

@end
