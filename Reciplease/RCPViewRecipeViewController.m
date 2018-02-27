//
//  RCPViewRecipeViewController.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/21/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPViewRecipeViewController.h"
#import "RCPHomeViewController.h"
#import "RCPRecipeIngredientTableViewCell.h"
#import "RCPRecipeInstructionTableViewCell.h"
#import "RCPRecipeImageCollectionViewCell.h"
#import "RCPEditRecipeViewController.h"
#import "RCPImageDisplayViewController.h"

@interface RCPViewRecipeViewController () <UITableViewDelegate, UITableViewDataSource, RCPHomeViewControllerDelegate, RCPEditRecipeViewControllerDelegate, UITextViewDelegate, RCPImageDisplayViewControllerDelegate>

//Recipe Outlets
@property (weak, nonatomic) IBOutlet UITextView *recipeNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UIButton *recipeImageButton;

//Table Views
@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property (weak, nonatomic) IBOutlet UITableView *instructionsTableView;

//Data Sources
@property (nonatomic, strong) NSMutableArray *allCategoriesArray;
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) NSMutableArray *ingredientsArray;
@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (nonatomic, strong) NSMutableArray *instructionsArray;

//Picker View
@property (nonatomic, strong) NSMutableArray *pickerViewArray;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

//Other
@property (weak, nonatomic) IBOutlet UIButton *xCloseButton;
@property (weak, nonatomic) IBOutlet UITextView *categoriesTextView;

//Star Rating
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *starButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *starImageViewCollection;

//Favorite
@property (weak, nonatomic) IBOutlet UIImageView *favoriteHeartImageView;


//Constraints For Parent Views
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoriesParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ingredientsParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *instructionsParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesParentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsParentViewHeightConstraint;

//Recipe Parent Views (Title, Categories, Ingredients, Instructions, Images, Notes, Tags)

//Title
@property (weak, nonatomic) IBOutlet UIView *titleParentView;

//Categories
@property (weak, nonatomic) IBOutlet UIView *categoriesParentView;

//Ingredients
@property (weak, nonatomic) IBOutlet UIView *ingredientsParentView;
@property (weak, nonatomic) IBOutlet UIView *ingredientsHeaderView;
@property (weak, nonatomic) IBOutlet UIView *ingredientsFooterView;

//Instructions
@property (weak, nonatomic) IBOutlet UIView *instructionsParentView;

//Images
@property (weak, nonatomic) IBOutlet UIView *imagesParentView;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (nonatomic, strong) NSMutableArray *imagesArray;

//Notes
@property (weak, nonatomic) IBOutlet UIView *notesParentView;

//Tags
@property (weak, nonatomic) IBOutlet UIView *tagsParentView;
@property (weak, nonatomic) IBOutlet UITextView *tagsTextView;

//Image Display VC
@property (nonatomic, strong) RCPImageDisplayViewController *imageDisplayVC;
@property (nonatomic, strong) NSIndexPath *selectedImageIndexPath;

@end

@implementation RCPViewRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"%@ - viewDidLoad", NSStringFromClass(self.class));
    [self setupTableViews];
    [self setupCollectionViews];
    [self setupXButton];
    [self loadRecipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //NSLog(@"View did layout subviews.");
    
    //Recipe Name
    //Set the constraint height of the text view's parent view to fit the required size needed to display the full name.
    self.titleParentViewHeightConstraint.constant = ceilf([self.recipeNameTextView sizeThatFits:CGSizeMake(self.recipeNameTextView.frame.size.width, FLT_MAX)].height);
    [self.recipeNameTextView layoutIfNeeded];
    [self.recipeNameTextView updateConstraints];
    
    //Categories
    self.categoriesParentViewHeightConstraint.constant = ceilf([self.categoriesTextView sizeThatFits:CGSizeMake(self.categoriesTextView.frame.size.width, FLT_MAX)].height + 9 + 35); //9 and 35 for top and bottom buffer space.
    [self.categoriesTextView layoutIfNeeded];
    [self.categoriesTextView updateConstraints];
    
    //Ingredients
    self.ingredientsParentViewHeightConstraint.constant = self.ingredientsHeaderView.frame.size.height + self.ingredientsArray.count * 36.0 + self.ingredientsFooterView.frame.size.height;
    
    //Instructions
    float totalStepsParentViewHeight = 0.0;
    for (RCPRecipeInstruction *instruction in self.instructionsArray){
        NSInteger instructionIndex = [self.instructionsArray indexOfObject:instruction];
        //Determine how tall the textview needs to be for the instruction, then add to the total.
        RCPRecipeInstructionTableViewCell *cell = [self.instructionsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:instructionIndex inSection:0]];
        //8 and 8 for top and bottom buffer space:
        float determinedHeight = ceilf([cell.instructionsTextView sizeThatFits:CGSizeMake(cell.instructionsTextView.frame.size.width, FLT_MAX)].height + 8 + 8);
        determinedHeight = MAX(44, determinedHeight);
        //NSLog(@"Determined height: %f", determinedHeight);
        totalStepsParentViewHeight += determinedHeight;
    }
    self.instructionsParentViewHeightConstraint.constant = 49 + 35 + totalStepsParentViewHeight;
    //NSLog(@"height set to: %f", self.instructionsParentViewHeightConstraint.constant);
    
    
    //Images (If any exist, has height, otherwise 0 height.)
    self.imagesParentViewHeightConstraint.constant = self.imagesArray.count > 0 ? 140 : 0;
    
    //Additional Notes
    self.notesParentViewHeightConstraint.constant = ceilf([self.notesTextView sizeThatFits:CGSizeMake(self.notesTextView.frame.size.width, FLT_MAX)].height + 84 + 60); //84 and 60 for top and bottom buffer space.
    
    //Tags
    self.tagsParentViewHeightConstraint.constant = ceilf([self.tagsTextView sizeThatFits:CGSizeMake(self.tagsTextView.frame.size.width, FLT_MAX)].height + 60); //60 for bottom buffer space.
}

#pragma mark - Helper Methods
-(void)setupXButton {
    self.xCloseButton.transform = CGAffineTransformRotate(self.xCloseButton.transform, M_PI_4);
}

-(void)setupTableViews {
    //Register Nibs
    [self.ingredientsTableView registerNib:[UINib nibWithNibName:@"RCPRecipeIngredientTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RCPRecipeIngredientTableViewCell class])];
    [self.instructionsTableView registerNib:[UINib nibWithNibName:@"RCPRecipeInstructionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([RCPRecipeInstructionTableViewCell class])];
    
    //Estimated Row Height setup for instructions table.
    self.instructionsTableView.rowHeight = UITableViewAutomaticDimension;
    self.instructionsTableView.estimatedRowHeight = 50;
}

-(void)setupCollectionViews {
    //Register Nib
    [self.imagesCollectionView registerNib:[UINib nibWithNibName:@"RCPRecipeImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPRecipeImageCollectionViewCell class])];
    
    //Load images for this recipe into the imagesArray.
    self.imagesArray = [NSMutableArray new];
    self.imagesArray = [self.recipe.images.allObjects mutableCopy];
}

-(void)loadRecipe {
    
    [self reloadIngredients];
    [self reloadInstructions];
    [self reloadRecipeImages];
    //Recipe Cover Image
    [self reloadDefaultRecipeImage];
    
    
    //Rating
    NSInteger rating = self.recipe.recipeRating;
    for (UIImageView *starImageView in self.starImageViewCollection){
        NSInteger index = [self.starImageViewCollection indexOfObject:starImageView];
        if (rating > 0){
            starImageView.image = rating >= index+1 ? [UIImage imageNamed:@"starNew"] : [UIImage imageNamed:@"starEmpty"];
        }
        else {
            starImageView.image = [UIImage imageNamed:@"starEmpty"];
        }
    }
    
    //Favorite
    self.favoriteHeartImageView.image = self.recipe.recipeIsFavorite ? [UIImage imageNamed:@"favHeartRed"] : [UIImage imageNamed:@"favHeartWhite"];
    
    //Recipe Name
    self.recipeNameTextView.text = self.recipe.recipeName.length > 0 ? self.recipe.recipeName : @"";
    self.recipeNameTextView.text = self.recipe.recipeName.length > 0 ? self.recipe.recipeName.uppercaseString : @"";
    self.recipeNameTextView.textContainerInset = UIEdgeInsetsZero;
    self.recipeNameTextView.textContainer.lineFragmentPadding = 0;
    
    //Categories
    self.categoriesTextView.textContainerInset = UIEdgeInsetsZero;
    self.categoriesTextView.textContainer.lineFragmentPadding = 0;
    NSString *allCategoriesWithCommas = [[self.recipe.categories.allObjects valueForKey:@"categoryName"] componentsJoinedByString:@", "];
    self.categoriesTextView.text = allCategoriesWithCommas;
    
    //Additional Notes
    self.notesTextView.textContainerInset = UIEdgeInsetsZero;
    self.notesTextView.textContainer.lineFragmentPadding = 0;
    self.notesTextView.text = self.recipe.recipeNotes.length > 0 ? self.recipe.recipeNotes : @"";
    
    //Tags
    self.tagsTextView.textContainerInset = UIEdgeInsetsZero;
    self.tagsTextView.textContainer.lineFragmentPadding = 0;
    NSString *allTagsWithCommas = [[self.recipe.tags.allObjects valueForKey:@"tagString"] componentsJoinedByString:@", "];
    self.tagsTextView.text = allTagsWithCommas;
}

-(void)reloadDefaultRecipeImage {
    
    //Load recipe image.
    RCPRecipeImage *featuredRecipeImageObject = [[self.recipe.images.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isFeatured == TRUE"]] firstObject];
    if (featuredRecipeImageObject){
        //Found the featured image - use this one.
        UIImage *recipeImage = [UIImage imageNamed:featuredRecipeImageObject.recipeImageName];
        if (recipeImage){
            self.recipeImageView.image = recipeImage;
        }
        else {
            NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:featuredRecipeImageObject.recipeImageName];
            self.recipeImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
        }
    }
    else {
        //No featured image found - default to the first one found.
        RCPRecipeImage *defaultedRecipeImageObject = [self.recipe.images.allObjects firstObject];
        if (defaultedRecipeImageObject){
            //Found the featured image - use this one.
            UIImage *recipeImage = [UIImage imageNamed:defaultedRecipeImageObject.recipeImageName];
            if (recipeImage){
                self.recipeImageView.image = recipeImage;
            }
            else {
                NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:defaultedRecipeImageObject.recipeImageName];
                self.recipeImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
            }
        }
        else {
            //Load the default 'reciplease' background asset.
            self.recipeImageView.image = [UIImage imageNamed:@"reciSplashscreen"];
        }
    }
}

-(void)reloadIngredients {
    self.ingredientsArray = self.recipe.recipeIngredients.allObjects.mutableCopy;
    self.ingredientsArray = [[self.recipe.recipeIngredients.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeIngredient *obj1, RCPRecipeIngredient *obj2) {
        return [obj1.ingredientNumber compare:obj2.ingredientNumber];
    }] mutableCopy];
    [self.ingredientsTableView reloadData];
}

-(void)reloadInstructions {
    self.instructionsArray = self.recipe.instructions.allObjects.mutableCopy;
    self.instructionsArray = [[self.recipe.instructions.allObjects sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeInstruction *obj1, RCPRecipeInstruction *obj2) {
        return [obj1.instructionNumber compare:obj2.instructionNumber];
    }] mutableCopy];
    [self.instructionsTableView reloadData];
    [self viewDidLayoutSubviews];
}

-(void)reloadRecipeImages {
    self.imagesArray = self.recipe.images.allObjects.mutableCopy;
    [self.imagesCollectionView reloadData];
}

#pragma mark - UITableView Delegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([tableView isEqual:self.ingredientsTableView]){
//        return 36.0;
//    }
////    else if ([tableView isEqual:self.instructionsTableView]){
////        return 36.0;
////    }
//    return 0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.ingredientsTableView]){
        return self.ingredientsArray.count;
    }
    else if ([tableView isEqual:self.instructionsTableView]){
        return self.instructionsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.ingredientsTableView]){
        RCPRecipeIngredientTableViewCell *cell = (RCPRecipeIngredientTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RCPRecipeIngredientTableViewCell class])];
        RCPRecipeIngredient *recipeIngredient = [self.ingredientsArray objectAtIndex:indexPath.row];
        
        cell.quantityTextField.text = recipeIngredient.ingredientQuantity.length > 0 ? recipeIngredient.ingredientQuantity : @"";
        cell.measurementTypeTextField.text = recipeIngredient.ingredientMeasurement.length > 0 ? recipeIngredient.ingredientMeasurement : @"";
        cell.ingredientNameTextField.text = recipeIngredient.ingredient.ingredientName.length > 0 ? recipeIngredient.ingredient.ingredientName : @"";
        cell.quantityTextField.tag = indexPath.row;
        cell.measurementTypeTextField.tag = indexPath.row;
        cell.ingredientNameTextField.tag = indexPath.row;
        
        cell.quantityTextField.delegate = self;
        cell.measurementTypeTextField.delegate = self;
        cell.ingredientNameTextField.delegate = self;
        
        cell.quantityTextField.enabled = NO;
        cell.measurementTypeTextField.enabled = NO;
        cell.ingredientNameTextField.enabled = NO;
       
        cell.measurementTypeTextField.inputView = self.pickerView;
        cell.measurementTypeTextField.inputAccessoryView = self.toolBar;
        
        return cell;
    }
    else {
        RCPRecipeInstructionTableViewCell *cell = (RCPRecipeInstructionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RCPRecipeInstructionTableViewCell class])];
        RCPRecipeInstruction *instruction = [self.instructionsArray objectAtIndex:indexPath.row];
        
        NSString *instructionNumber = instruction.instructionNumber ? [NSString stringWithFormat:@"%@. ", instruction.instructionNumber] : @"";
        
        cell.instructionsTextView.text = instruction.instructionText.length > 0 ? [NSString stringWithFormat:@"%@%@", instructionNumber, instruction.instructionText] : @"";
        cell.instructionsTextView.textContainerInset = UIEdgeInsetsZero;
        cell.instructionsTextView.textContainer.lineFragmentPadding = 0;
        
        
        
        cell.instructionsTextView.editable = NO;
        cell.instructionsTextView.delegate = self;
        cell.instructionsTextView.tag = indexPath.row;
        
        [cell updateConstraintsIfNeeded];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"tableView:didSelectRowAtIndexPath: %@ (Row: %ld)", indexPath, (long)indexPath.row);
    
}



#pragma mark - Button Actions
- (IBAction)starButtonTapped:(UIButton *)sender {
    //NSLog(@"Set rating: %ld", (long)sender.tag);
    NSInteger rating = sender.tag;
    for (UIImageView *starImageView in self.starImageViewCollection){
        NSInteger index = [self.starImageViewCollection indexOfObject:starImageView];
        if (rating > 0){
            starImageView.image = rating >= index+1 ? [UIImage imageNamed:@"starNew"] : [UIImage imageNamed:@"starEmpty"];
        }
        else {
            starImageView.image = [UIImage imageNamed:@"starEmpty"];
        }
    }
    self.recipe.recipeRating = rating;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)favoriteRecipeButtonTapped:(UIButton *)sender {
    self.recipe.recipeIsFavorite = !self.recipe.recipeIsFavorite;
    self.favoriteHeartImageView.image = self.recipe.recipeIsFavorite ? [UIImage imageNamed:@"favHeartRed"] : [UIImage imageNamed:@"favHeartWhite"];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}



- (IBAction)cancelButtonTapped:(UIButton *)sender {
    //NSLog(@"Cancel Recipe!");
    if ([self.delegate respondsToSelector:@selector(recipeClosed:)]){
        [self.delegate recipeClosed:self.recipe];
    }
    else {
        //NSLog(@"Delegate does not respond to selector: recipeClosed:");
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"Dismissed view recipe view controller.");
    }];
}

- (IBAction)editButtonTapped:(UIButton *)sender {
    //NSLog(@"Edit button tapped!");
    
    //Need to present the RCPEditRecipeVC modally (edit mode).
    
    [self performSegueWithIdentifier:@"viewToEdit" sender:self];
    
}



- (IBAction)testConstraintButtonTapped:(UIButton *)sender {
    //Set the constraint height of the text view's parent view to fit the required size needed to display the full name.
//    self.titleParentViewHeightConstraint.constant = ceilf([self.recipeNameTextView sizeThatFits:CGSizeMake(self.recipeNameTextView.frame.size.width, FLT_MAX)].height);
//    //NSLog(@"Title parent view height constraint is set to: %f", self.titleParentViewHeightConstraint.constant);
//    [self.recipeNameTextView layoutIfNeeded];
//    [self.recipeNameTextView updateConstraints];
//

    [self viewDidLayoutSubviews];
    
}


#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RCPRecipeImageCollectionViewCell *cell = (RCPRecipeImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPRecipeImageCollectionViewCell class]) forIndexPath:indexPath];
    RCPRecipeImage *recipeImage = [self.imagesArray objectAtIndex:indexPath.row];
    
    //NSLog(@"Loading image: %@", recipeImage.recipeImageName);
    UIImage *image = [UIImage imageNamed:recipeImage.recipeImageName];
    if (image){
        cell.recipeImageView.image = image;
    }
    else {
        NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:recipeImage.recipeImageName];
        if (imagePathString.length > 0){
            cell.recipeImageView.image = [UIImage imageWithContentsOfFile:imagePathString];
        }
        else {
            cell.recipeImageView.backgroundColor = [UIColor blackColor];
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"collectionView:didSelectItemAtIndexPath: %@ (Row: %ld)", indexPath, (long)indexPath.row);
    
    self.selectedImageIndexPath = indexPath;
    
    
    
//    if (!self.imageDisplayVC){
//        self.imageDisplayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RCPImageDisplayViewController"];
//        self.imageDisplayVC.delegate = self;
//    }
    
    
    
    //Display full screen image viewer.
    [self performSegueWithIdentifier:@"viewRecipeImageSegue" sender:self];
    
    
//    [self presentViewController:self.imageDisplayVC animated:YES completion:^{
//        //NSLog(@"Presented!");
//        //NSLog(@"Add category VC: %@", NSStringFromCGRect(self.imageDisplayVC.view.frame));
//    }];
    
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"viewToEdit"]){
        RCPEditRecipeViewController *editRecipeVC = [segue destinationViewController];
        [[RCPCoreDataManager sharedInstance] setupCreatingRecipeContext];
        RCPRecipe *editingRecipe = self.recipe;
        editRecipeVC.recipe = editingRecipe;
        editRecipeVC.addingRecipe = NO;
        editRecipeVC.editingRecipe = YES;
        editRecipeVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"viewRecipeImageSegue"]){
        RCPRecipeImage *recipeImage = [self.imagesArray objectAtIndex:self.selectedImageIndexPath.row];
        UIImage *image = [UIImage imageNamed:recipeImage.recipeImageName];
        if (!image){
            NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:recipeImage.recipeImageName];
            image = [UIImage imageWithContentsOfFile:imagePathString];
        }
        
        RCPImageDisplayViewController *imageVC = (RCPImageDisplayViewController*)[segue destinationViewController];
        imageVC.delegate = self;
        imageVC.imageToDisplay = image;
    }
    
}

#pragma mark - Edit Recipe Delegate
-(void)recipeWasUpdated:(RCPRecipe *)updatedRecipe {
    //NSLog(@"Recipe was updated.");
    [self loadRecipe];
}

-(void)recipeWasDeleted {
    //NSLog(@"Recipe was deleted.");

    if ([self.delegate respondsToSelector:@selector(recipeClosed:)]){
        [self.delegate recipeClosed:self.recipe];
    }
    else {
        //NSLog(@"Delegate does not respond to selector: recipeClosed:");
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"Dismissed view recipe view controller.");
    }];
}

#pragma mark - UITextView Delegate
-(void)textViewDidChange:(UITextView *)textView {
    
    if (self.instructionsArray.count > 0){
        RCPRecipeInstructionTableViewCell *instructionCell = (RCPRecipeInstructionTableViewCell*)[self.instructionsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag inSection:0]];
        if ([textView isEqual:instructionCell.instructionsTextView]){
            [self.instructionsTableView beginUpdates];
            [self.instructionsTableView endUpdates];
            [self viewDidLayoutSubviews];
        }
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    //NSLog(@"Text view did begin editing.");
    
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    //NSLog(@"Text view did end editing.");
    
    
    
}

#pragma mark - RCPImageDisplayViewControllerDelegate
-(void)imageDisplayViewTappedClose {
    //NSLog(@"Close.");
    [self.imageDisplayVC dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
