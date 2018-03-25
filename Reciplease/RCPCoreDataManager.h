//
//  RCPCoreDataManager.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/19/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCPCoreDataManager : NSObject

+ (instancetype)sharedInstance;
-(void)createCategories;
-(void)createRecipePackOneRecipes;
-(void)setupCreatingRecipeContext;

//Build Patches
-(void)applyBuild2Patch;

@property (nonatomic) NSManagedObjectContext *creatingRecipeContext;

@end
