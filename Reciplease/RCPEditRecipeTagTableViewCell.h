//
//  RCPEditRecipeTagTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 11/20/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPEditRecipeTagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *tagParentView;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UIImageView *xDeleteImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteOverlayButton;

@end
