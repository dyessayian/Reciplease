//
//  RCPRecipeTag+CoreDataProperties.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/29/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPRecipeTag+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RCPRecipeTag (CoreDataProperties)

+ (NSFetchRequest<RCPRecipeTag *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tagString;
@property (nullable, nonatomic, copy) NSNumber *tagNumber;
@property (nullable, nonatomic, retain) NSSet<RCPRecipe *> *recipe;

@end

@interface RCPRecipeTag (CoreDataGeneratedAccessors)

- (void)addRecipeObject:(RCPRecipe *)value;
- (void)removeRecipeObject:(RCPRecipe *)value;
- (void)addRecipe:(NSSet<RCPRecipe *> *)values;
- (void)removeRecipe:(NSSet<RCPRecipe *> *)values;

@end

NS_ASSUME_NONNULL_END
