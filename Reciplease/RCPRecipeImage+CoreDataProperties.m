//
//  RCPRecipeImage+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 10/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//
//

#import "RCPRecipeImage+CoreDataProperties.h"

@implementation RCPRecipeImage (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeImage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipeImage"];
}

@dynamic recipeImageName;
@dynamic isFeatured;
@dynamic recipe;

@end
