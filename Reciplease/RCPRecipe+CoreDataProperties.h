//
//  RCPRecipe+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 10/22/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//
//

#import "RCPRecipe+CoreDataClass.h"
#import "RCPRecipeTag+CoreDataClass.h"
#import "RCPRecipeImage+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipe (CoreDataProperties)

+ (NSFetchRequest<RCPRecipe *> *)fetchRequest;

@property (nonatomic) BOOL recipeIsFavorite;
@property (nullable, nonatomic, copy) NSString *recipeName;
@property (nullable, nonatomic, copy) NSString *recipeNotes;
@property (nonatomic) int16_t recipeRating;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeCategory *> *categories;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeInstruction *> *instructions;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeIngredient *> *recipeIngredients;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeTag *> *tags;
@property (nullable, nonatomic, retain) NSSet<RCPRecipeImage *> *images;

@end

@interface RCPRecipe (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(RCPRecipeCategory *)value;
- (void)removeCategoriesObject:(RCPRecipeCategory *)value;
- (void)addCategories:(NSSet<RCPRecipeCategory *> *)values;
- (void)removeCategories:(NSSet<RCPRecipeCategory *> *)values;

- (void)addInstructionsObject:(RCPRecipeInstruction *)value;
- (void)removeInstructionsObject:(RCPRecipeInstruction *)value;
- (void)addInstructions:(NSSet<RCPRecipeInstruction *> *)values;
- (void)removeInstructions:(NSSet<RCPRecipeInstruction *> *)values;

- (void)addRecipeIngredientsObject:(RCPRecipeIngredient *)value;
- (void)removeRecipeIngredientsObject:(RCPRecipeIngredient *)value;
- (void)addRecipeIngredients:(NSSet<RCPRecipeIngredient *> *)values;
- (void)removeRecipeIngredients:(NSSet<RCPRecipeIngredient *> *)values;

- (void)addTagsObject:(RCPRecipeTag *)value;
- (void)removeTagsObject:(RCPRecipeTag *)value;
- (void)addTags:(NSSet<RCPRecipeTag *> *)values;
- (void)removeTags:(NSSet<RCPRecipeTag *> *)values;

- (void)addImagesObject:(RCPRecipeImage *)value;
- (void)removeImagesObject:(RCPRecipeImage *)value;
- (void)addImages:(NSSet<RCPRecipeImage *> *)values;
- (void)removeImages:(NSSet<RCPRecipeImage *> *)values;

@end

NS_ASSUME_NONNULL_END
