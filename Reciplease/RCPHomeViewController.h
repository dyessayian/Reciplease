//
//  RCPHomeViewController.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/16/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCPHomeViewControllerDelegate;


@interface RCPHomeViewController : UIViewController


@property (nonatomic, weak) id<RCPHomeViewControllerDelegate>delegate;



@end

@protocol RCPHomeViewControllerDelegate <NSObject>

@optional

@end
