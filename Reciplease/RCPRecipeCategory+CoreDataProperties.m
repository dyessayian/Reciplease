//
//  RCPRecipeCategory+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeCategory+CoreDataProperties.h"

@implementation RCPRecipeCategory (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipeCategory"];
}

@dynamic categoryID;
@dynamic categoryName;
@dynamic imageName;
@dynamic recipes;

@end
