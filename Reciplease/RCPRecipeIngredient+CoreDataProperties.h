//
//  RCPRecipeIngredient+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/29/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeIngredient+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeIngredient (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeIngredient *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *ingredientMeasurement;
@property (nullable, nonatomic, copy) NSString *ingredientQuantity;
@property (nullable, nonatomic, copy) NSNumber *ingredientNumber;
@property (nullable, nonatomic, retain) RCPIngredient *ingredient;
@property (nullable, nonatomic, retain) RCPRecipe *recipe;

@end

NS_ASSUME_NONNULL_END
