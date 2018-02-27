//
//  RCPAddCategoryViewController.h
//  Reciplease
//
//  Created by Daniel Yessayian on 9/4/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCPAddCategoryViewControllerDelegate;

@interface RCPAddCategoryViewController : UIViewController

@property (weak, nonatomic) id<RCPAddCategoryViewControllerDelegate>delegate;

@end

@protocol RCPAddCategoryViewControllerDelegate <NSObject>

@optional

-(void)categoryWasAdded:(RCPRecipeCategory*)addedCategory;

@end
