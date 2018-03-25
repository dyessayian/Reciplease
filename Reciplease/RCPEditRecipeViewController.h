//
//  RCPEditRecipeViewController.h
//  Reciplease
//
//  Created by Daniel Yessayian on 10/24/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCPEditRecipeViewControllerDelegate;

@interface RCPEditRecipeViewController : UIViewController
@property (nonatomic, strong) RCPRecipe *recipe;
@property (weak, nonatomic) id<RCPEditRecipeViewControllerDelegate>delegate;
@property (nonatomic) BOOL addingRecipe;
@property (nonatomic) BOOL editingRecipe;
@end

@protocol RCPEditRecipeViewControllerDelegate <NSObject>
@optional
-(void)recipeWasAdded:(RCPRecipe*)addedRecipe;
-(void)recipeWasUpdated:(RCPRecipe*)updatedRecipe;
-(void)recipeWasDeleted;
-(void)recipeViewCanceled;
@end
