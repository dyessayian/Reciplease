//
//  RCPImageDisplayViewController.h
//  Reciplease
//
//  Created by Daniel Yessayian on 1/14/18.
//  Copyright © 2018 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCPImageDisplayViewControllerDelegate;

@interface RCPImageDisplayViewController : UIViewController
@property (nonatomic) id<RCPImageDisplayViewControllerDelegate> delegate;
@property (nonatomic, strong) UIImage *imageToDisplay;
@end

@protocol RCPImageDisplayViewControllerDelegate <NSObject>
- (void) imageDisplayViewTappedClose;
@end
