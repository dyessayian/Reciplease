//
//  RCPRecipeIngredientTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/24/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPRecipeIngredientTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *measurementTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *ingredientNameTextField;

@end
