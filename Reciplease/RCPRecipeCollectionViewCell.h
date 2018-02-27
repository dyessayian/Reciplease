//
//  RCPRecipeCollectionViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/23/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPRecipeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UITextView *recipeNameTextView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteHeartButton;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteHeartImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingStarImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recipeNameTextViewHeightConstraint;

@end
