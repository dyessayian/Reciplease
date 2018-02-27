//
//  RCPRecipeInstruction+CoreDataProperties.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeInstruction+CoreDataProperties.h"

@implementation RCPRecipeInstruction (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeInstruction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RCPRecipeInstruction"];
}

@dynamic instructionNumber;
@dynamic instructionText;
@dynamic recipe;

@end
