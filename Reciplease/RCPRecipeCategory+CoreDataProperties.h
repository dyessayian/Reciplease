//
//  RCPRecipeCategory+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeCategory (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *categoryID;
@property (nullable, nonatomic, copy) NSString *categoryName;
@property (nullable, nonatomic, copy) NSString *imageName;
@property (nullable, nonatomic, retain) NSSet<RCPRecipe *> *recipes;

@end

@interface RCPRecipeCategory (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(RCPRecipe *)value;
- (void)removeRecipesObject:(RCPRecipe *)value;
- (void)addRecipes:(NSSet<RCPRecipe *> *)values;
- (void)removeRecipes:(NSSet<RCPRecipe *> *)values;

@end

NS_ASSUME_NONNULL_END
