//
//  RCPAddCategoryViewController.m
//  Reciplease
//
//  Created by Daniel Yessayian on 9/4/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPAddCategoryViewController.h"
#import "RCPAddCategoryCollectionViewCell.h"

@interface RCPAddCategoryViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *categoryImagesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *addCategoryCollectionView;
@property (weak, nonatomic) IBOutlet UIView *categoryNameParentView;
@property (weak, nonatomic) IBOutlet UIView *categoryIconsParentView;
@property (nonatomic, strong) NSIndexPath *selectedIconIndexPath;
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *categoryCircleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *currentCategoryImageView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation RCPAddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedIconIndexPath = nil;
    [self setupCollectionView];
    [self setupCategoryCircleLabel];
    [self setupCollectionViewParent];
    [self setupXCloseButton];
    [self setupGestureRecognizers];
    [self setupSelectedCategoryImageView];
    [self handleAddButtonStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture Recognizers
-(void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)handleTap:(UITapGestureRecognizer*)sender {
    [self.view endEditing:YES];
}

#pragma mark - Helper Methods
-(void)setupSelectedCategoryImageView {
    if (self.selectedIconIndexPath){
        UIImage *selectedImage = [UIImage imageNamed:[self.categoryImagesArray objectAtIndex:self.selectedIconIndexPath.row]];
        self.currentCategoryImageView.image = selectedImage;
    }
    else {
        self.currentCategoryImageView.image = nil;
    }
}


-(void)setupXCloseButton {
    self.cancelButton.transform = CGAffineTransformRotate(self.cancelButton.transform, M_PI_4);
}

-(void)setupCollectionViewParent {
    self.categoryIconsParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
    self.categoryIconsParentView.layer.borderWidth = 1.0;
}

-(void)setupCategoryCircleLabel {
    self.categoryCircleLabel.layer.borderColor = [UIColor colorNamed:@"azulColor"].CGColor;
    self.categoryCircleLabel.layer.borderWidth = 2;
}

-(void)setupCollectionView {
    
    self.categoryImagesArray = [NSMutableArray new];
    
//    [self.categoryImagesArray addObjectsFromArray:@[@"category_all", @"category_american", @"category_chinese", @"category_cocktails", @"category_french", @"category_italian", @"category_japanese", @"category_mexican"]];
    

    //Add Category_1 assets.
    for (int i = 1; i < 160; i++){
        [self.categoryImagesArray addObject:[NSString stringWithFormat:@"category_final_%d", i]];
    }
    if (!self.selectedIconIndexPath){
        self.selectedIconIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    
    [self.addCategoryCollectionView registerNib:[UINib nibWithNibName:@"RCPAddCategoryCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPAddCategoryCollectionViewCell class])];
    

    
}

#pragma mark - Button Events
- (IBAction)cancelButtonTapped:(UIButton *)sender {
    //NSLog(@"Cancel Category!");
    
    [self dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"Dismissed add category view controller.");
    }];
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    //NSLog(@"Add Category!");
    
    if (self.categoryNameTextField.text.length > 0){
        
        if (self.selectedIconIndexPath != nil){
            //Add check for existing category matching the name, and prevent.
            RCPRecipeCategory *category = [RCPRecipeCategory MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"categoryName ==[cd] %@", self.categoryNameTextField.text]];
            //RCPRecipeCategory *category = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:self.categoryNameTextField.text];
            if (category){
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Category Exists" message:[NSString stringWithFormat:@"A category already exists with that name, please try another."] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {  }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else {

                //Determine the upcoming ID for this category.
                NSArray *allCategories = [RCPRecipeCategory MR_findAll];
                NSNumber *newCategoryID = @([[[allCategories valueForKey:@"categoryID"] valueForKeyPath:@"@max.intValue"] integerValue] + 1);

                //Create the category with the selected image and the entered name.
                RCPRecipeCategory *createdCategory = [RCPRecipeCategory MR_createEntity];
                createdCategory.categoryID = newCategoryID;
                createdCategory.categoryName = self.categoryNameTextField.text;
                createdCategory.imageName = [self.categoryImagesArray objectAtIndex:self.selectedIconIndexPath.row];

                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

                if ([self.delegate respondsToSelector:@selector(categoryWasAdded:)]){
                    [self.delegate categoryWasAdded:createdCategory];
                }
                else {
                    //NSLog(@"Delegate does not respond to selector categoryWasAdded:");
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    //NSLog(@"Dismissed add category view controller.");
                }];
            }
        }
        else {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Missing Category Icon" message:[NSString stringWithFormat:@"Please select an icon for the new category."] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {  }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Missing Category Name" message:[NSString stringWithFormat:@"Please fill out a name for the new category."] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {  }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryImagesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RCPAddCategoryCollectionViewCell *cell = (RCPAddCategoryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPAddCategoryCollectionViewCell class]) forIndexPath:indexPath];
    
    NSString *imageNameString = [self.categoryImagesArray objectAtIndex:indexPath.row];
    cell.addCategoryImageView.image = [UIImage imageNamed:imageNameString];
    
    //cell.colorLabel.backgroundColor = [[RCPAppManager sharedInstance].appColorsArray objectAtIndex:indexPath.row % [RCPAppManager sharedInstance].appColorsArray.count];
//    cell.colorLabel.layer.cornerRadius = cell.colorLabel.frame.size.height / 2;
    
    if ([indexPath isEqual:self.selectedIconIndexPath]){
        //cell.backgroundColor = [UIColor blackColor];
        cell.addCategoryImageView.tintColor = [UIColor colorNamed:@"azulColor"];
    }
    else {
        //cell.backgroundColor = [UIColor clearColor];
        cell.addCategoryImageView.tintColor = [UIColor blackColor];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"collectionView:didSelectItemAtIndexPath: %@ (Row: %ld)", indexPath, (long)indexPath.row);
    self.selectedIconIndexPath = indexPath;
    [self setupSelectedCategoryImageView];
    [self.addCategoryCollectionView reloadData];
    [self handleAddButtonStatus];
}

#pragma mark - UITextField Delegate
- (IBAction)categoryNameTextFieldChanged:(UITextField *)sender {
    [self handleAddButtonStatus];
}

-(void)handleAddButtonStatus {
    if (self.categoryNameTextField.text.length > 0 && self.selectedIconIndexPath != nil){
        self.addButton.enabled = YES;
    }
    else {
        self.addButton.enabled = NO;
    }
    [self handleAddButtonAppearance];
}

-(void)handleAddButtonAppearance {
    if (self.addButton.enabled){
        [self.addButton setBackgroundColor:[UIColor colorNamed:@"azulColor"]];
    }
    else {
        [self.addButton setBackgroundColor:[UIColor colorNamed:@"inactiveCategoryImageColor"]];
    }
}

@end
