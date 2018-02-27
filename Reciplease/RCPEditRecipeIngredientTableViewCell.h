//
//  RCPEditRecipeIngredientTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 11/6/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPEditRecipeIngredientTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *amountParentView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIView *unitParentView;
@property (weak, nonatomic) IBOutlet UITextField *unitTextField;
@property (weak, nonatomic) IBOutlet UIView *ingredientParentView;
@property (weak, nonatomic) IBOutlet UITextField *ingredientTextField;
@property (weak, nonatomic) IBOutlet UIImageView *xDeleteImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteOverlayButton;

@end
