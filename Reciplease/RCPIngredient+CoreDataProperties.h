//
//  RCPIngredient+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPIngredient+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPIngredient (CoreDataProperties)

+ (NSFetchRequest<RCPIngredient *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *ingredientName;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeIngredient *> *recipeIngredient;

@end

@interface RCPIngredient (CoreDataGeneratedAccessors)

- (void)addRecipeIngredientObject:(RCPRecipeIngredient *)value;
- (void)removeRecipeIngredientObject:(RCPRecipeIngredient *)value;
- (void)addRecipeIngredient:(NSSet<RCPRecipeIngredient *> *)values;
- (void)removeRecipeIngredient:(NSSet<RCPRecipeIngredient *> *)values;

@end

NS_ASSUME_NONNULL_END
