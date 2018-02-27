//
//  RCPRecipeInstruction+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeInstruction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeInstruction (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeInstruction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *instructionNumber;
@property (nullable, nonatomic, copy) NSString *instructionText;
@property (nullable, nonatomic, retain) RCPRecipe *recipe;

@end

NS_ASSUME_NONNULL_END
