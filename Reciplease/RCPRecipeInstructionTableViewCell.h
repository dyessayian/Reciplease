//
//  RCPRecipeInstructionTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/24/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPRecipeInstructionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *instructionNumberLabel;
@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;

@end
