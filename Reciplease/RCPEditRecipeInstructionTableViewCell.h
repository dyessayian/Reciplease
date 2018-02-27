//
//  RCPEditRecipeInstructionTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 11/8/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPEditRecipeInstructionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stepNumberLabel;
@property (weak, nonatomic) IBOutlet UITextView *instructionTextView;
@property (weak, nonatomic) IBOutlet UIView *instructionParentView;
@property (weak, nonatomic) IBOutlet UIImageView *xDeleteImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteOverlayButton;

@end
