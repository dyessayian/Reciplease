//
//  RCPRecipe+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 10/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//
//

#import "RCPRecipe+CoreDataProperties.h"

@implementation RCPRecipe (CoreDataProperties)

+ (NSFetchRequest<RCPRecipe *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipe"];
}

@dynamic recipeIsFavorite;
@dynamic recipeName;
@dynamic recipeNotes;
@dynamic recipeRating;
@dynamic categories;
@dynamic instructions;
@dynamic recipeIngredients;
@dynamic tags;
@dynamic images;

@end
