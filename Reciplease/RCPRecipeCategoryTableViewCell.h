//
//  RCPRecipeCategoryTableViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/24/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPRecipeCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryCheckmarkImageView;

@end
