//
//  RCPRecipeTag+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/29/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeTag+CoreDataProperties.h"

@implementation RCPRecipeTag (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeTag *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipeTag"];
}

@dynamic tagString;
@dynamic tagNumber;
@dynamic recipe;

@end
