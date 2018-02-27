//
//  RCPRecipeCategorySelectCollectionViewCell.h
//  Reciplease
//
//  Created by Daniel Yessayian on 10/30/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPRecipeCategorySelectCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UIView *categoryParentView;

@end
