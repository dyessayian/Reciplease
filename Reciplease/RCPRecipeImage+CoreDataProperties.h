//
//  RCPRecipeImage+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 10/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//
//

#import "RCPRecipeImage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeImage (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeImage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *recipeImageName;
@property (nonatomic) BOOL isFeatured;
@property (nullable, nonatomic, retain) RCPRecipe *recipe;

@end

NS_ASSUME_NONNULL_END 
