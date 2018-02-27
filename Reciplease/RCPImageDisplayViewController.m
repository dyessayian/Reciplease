//
//  RCPImageDisplayViewController.m
//  Reciplease
//
//  Created by Daniel Yessayian on 1/14/18.
//  Copyright © 2018 Daniel Yessayian. All rights reserved.
//

#import "RCPImageDisplayViewController.h"

@interface RCPImageDisplayViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *xCloseButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *imageParentView;

@end

@implementation RCPImageDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupScrollView];
    self.imageView.image = self.imageToDisplay;
    self.imageParentView.layer.borderColor = [UIColor colorWithRed:36.0/255.0 green:36.0/255.0 blue:36.0/255.0 alpha:1].CGColor;
    self.imageParentView.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods
-(void)setupScrollView {
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.delegate = self;
}

#pragma mark - Button Actions

- (IBAction)closeButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(imageDisplayViewTappedClose)]){
        [self.delegate imageDisplayViewTappedClose];
    }
    else {
        //NSLog(@"Delegate does not respond to 'imageDisplayViewTappedClose'");
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
