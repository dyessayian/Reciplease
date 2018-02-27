//
//  RCPIngredient+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPIngredient+CoreDataProperties.h"

@implementation RCPIngredient (CoreDataProperties)

+ (NSFetchRequest<RCPIngredient *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPIngredient"];
}

@dynamic ingredientName;
@dynamic recipeIngredient;

@end
