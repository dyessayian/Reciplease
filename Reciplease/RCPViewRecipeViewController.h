//
//  RCPViewRecipeViewController.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/21/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCPViewRecipeViewControllerDelegate;

@interface RCPViewRecipeViewController : UIViewController
@property (nonatomic, strong) RCPRecipe *recipe;
@property (weak, nonatomic) id<RCPViewRecipeViewControllerDelegate>delegate;
@end

@protocol RCPViewRecipeViewControllerDelegate <NSObject>
@optional
-(void)recipeClosed:(RCPRecipe*)recipe;
@end
