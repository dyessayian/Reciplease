//
//  RCPHomeViewController.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/16/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPHomeViewController.h"
#import "RCPCategoryCollectionViewCell.h"
#import "RCPRecipeCollectionViewCell.h"
#import "RCPViewRecipeViewController.h"
#import "RCPEditRecipeViewController.h"


@interface RCPHomeViewController () <RCPEditRecipeViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, RCPViewRecipeViewControllerDelegate>

//Parent Views
@property (weak, nonatomic) IBOutlet UIView *titleParentView;
@property (weak, nonatomic) IBOutlet UIView *recipeCategoryParentView;
@property (weak, nonatomic) IBOutlet UIView *recipesParentView;

//Collection Views
@property (weak, nonatomic) IBOutlet UICollectionView *recipeCategoryCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *recipesCollectionView;

//Add Button
@property (weak, nonatomic) IBOutlet UIButton *addRecipeButton;

//Data Sources
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) NSMutableArray *recipesArray;
@property (nonatomic, strong) NSMutableArray *searchRecipesArray;

//Other
@property (nonatomic, strong) NSIndexPath *selectedCategoryIndexPath;
@property (nonatomic, strong) NSIndexPath *previousCategoryIndexPath;
@property (nonatomic) BOOL performingCollectionCategoryViewAnimations;
@property (nonatomic, strong) RCPRecipe *selectedRecipe;
@property (weak, nonatomic) IBOutlet UILabel *currentCategoryLabel;

//Search Bar
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *searchParentView;

//Favorites
@property (weak, nonatomic) IBOutlet UIImageView *favoriteHeartImageView;
@property (nonatomic) BOOL favoritesFilterOn;

//Fonts
@property (nonatomic) UIFont *activeCategoryFont;
@property (nonatomic) UIFont *inactiveCategoryFont;

@end

@implementation RCPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addObservers];
    [self setupFonts];
    [self setupCollectionView];
    [self setupSearchView];
    [self setupGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self reloadRecipes];
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
-(void)addObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectedCategoryDeleted:) name:@"CategoryDeleted" object:nil];
}

-(void)setFavoritesFilterOn:(BOOL)favoritesFilterOn {
    _favoritesFilterOn = favoritesFilterOn;
    self.favoriteHeartImageView.image = favoritesFilterOn ? [UIImage imageNamed:@"favHeartRed"] : [UIImage imageNamed:@"favHearGrey"];
}


-(void)setupFonts {
    self.activeCategoryFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
    self.inactiveCategoryFont = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    self.currentCategoryLabel.font = [UIFont fontWithName:@"BebasNeue" size:60.0];
}

-(void)setupSearchView {
    self.searchParentView.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0].CGColor;
    self.searchParentView.layer.borderWidth = 1.0f;
}

-(void)reloadRecipes {
    
    
    RCPRecipeCategory *selectedCategory = [self.categoriesArray objectAtIndex:self.selectedCategoryIndexPath.row];
    if ([selectedCategory.categoryName isEqualToString:@"All"]){
        if (self.favoritesFilterOn){
            self.recipesArray = [[[RCPRecipe MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"recipeIsFavorite == TRUE"]] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
                return [obj1.recipeName compare:obj2.recipeName];
            }] mutableCopy];
        }
        else {
            self.recipesArray = [[[RCPRecipe MR_findAll] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
                return [obj1.recipeName compare:obj2.recipeName];
            }] mutableCopy];
        }
    }
    else {
        if (self.favoritesFilterOn){
            self.recipesArray = [[[RCPRecipe MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"ANY categories.categoryName == %@ AND recipeIsFavorite == TRUE", selectedCategory.categoryName]] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
                return [obj1.recipeName compare:obj2.recipeName];
            }] mutableCopy];
        }
        else {
            self.recipesArray = [[[RCPRecipe MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"ANY categories.categoryName == %@", selectedCategory.categoryName]] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
                return [obj1.recipeName compare:obj2.recipeName];
            }] mutableCopy];
        }
    }
    
    self.searchRecipesArray = [[[self.recipesArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"recipeName CONTAINS[c] %@ OR ANY tags.tagString CONTAINS[c] %@", self.searchTextField.text, self.searchTextField.text]] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
        return [obj1.recipeName compare:obj2.recipeName];
    }] mutableCopy];
    
    //NSLog(@"Search Recipes: %@", self.searchRecipesArray);
    [self.recipesCollectionView reloadData];
    
}

-(void)reloadCategories {
    self.categoriesArray = [[[RCPRecipeCategory MR_findAll] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeCategory *obj1, RCPRecipeCategory  *obj2) {
        return [obj1.categoryName compare:obj2.categoryName];
    }] mutableCopy];
    
    if (self.categoriesArray.count > 0){
        if (self.selectedCategoryIndexPath){
            RCPRecipeCategory *selectedCategory = [self.categoriesArray objectAtIndex:self.selectedCategoryIndexPath.row];
            self.currentCategoryLabel.text = selectedCategory.categoryName.length > 0 ? selectedCategory.categoryName : @"";
        }
        else {
            RCPRecipeCategory *defaultedCategory = [self.categoriesArray firstObject];
            self.currentCategoryLabel.text = defaultedCategory.categoryName.length > 0 ? defaultedCategory.categoryName : @"";
            self.selectedCategoryIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        }
    }
    else {
        self.currentCategoryLabel.text = @"No Categories";
    }
    ////NSLog(@"Selected recipe category: %@", selectedCategory.categoryName);
    [self.recipeCategoryCollectionView reloadData];
}

-(void)setupCollectionView {
    
    self.selectedCategoryIndexPath = nil;
    self.previousCategoryIndexPath = nil;
    
    [self.recipeCategoryCollectionView registerNib:[UINib nibWithNibName:@"RCPCategoryCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPCategoryCollectionViewCell class])];
    
    [self.recipesCollectionView registerNib:[UINib nibWithNibName:@"RCPRecipeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([RCPRecipeCollectionViewCell class])];
    
    self.categoriesArray = [NSMutableArray new];
    self.recipesArray = [NSMutableArray new];
    
    self.categoriesArray = [[[RCPRecipeCategory MR_findAll] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipeCategory *obj1, RCPRecipeCategory  *obj2) {
        return [obj1.categoryName compare:obj2.categoryName];
    }] mutableCopy];
    
    self.recipesArray = [[[RCPRecipe MR_findAll] sortedArrayUsingComparator:^NSComparisonResult(RCPRecipe *obj1, RCPRecipe *obj2) {
        return [obj1.recipeName compare:obj2.recipeName];
    }] mutableCopy];
    
    self.selectedCategoryIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    if (self.categoriesArray.count > 0){
        [self.recipeCategoryCollectionView selectItemAtIndexPath:self.selectedCategoryIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    }
    
    //NSLog(@"Recipes array: %ld", self.recipesArray.count);
}


#pragma mark - Button Actions
- (IBAction)addRecipeButtonTapped:(UIButton *)sender {
    //NSLog(@"Add recipe button tapped.");
    
    [self performSegueWithIdentifier:@"addRecipeSegue" sender:nil];
    
}

- (IBAction)viewFavoritesButtonTapped:(UIButton *)sender {
    //NSLog(@"View favorites!");
    self.favoritesFilterOn = !self.favoritesFilterOn;
    [self reloadRecipes];
}

-(void)didToggleRecipeFavorite:(UIButton*)sender {
    
    RCPRecipe *selectedRecipe = [self.recipesArray objectAtIndex:sender.tag];
    //NSLog(@"Did toggle favorite for recipe: %@", selectedRecipe.recipeName);
    selectedRecipe.recipeIsFavorite = !selectedRecipe.recipeIsFavorite;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.recipesCollectionView reloadData];
}



#pragma mark - UICollectionView Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.recipesCollectionView]){
        float widthToUse = (self.view.frame.size.width - 60)/4;
        return CGSizeMake(widthToUse, widthToUse);
    }
    else if ([collectionView isEqual:self.recipeCategoryCollectionView]){
        return CGSizeMake(80, 80);
    }
    return CGSizeMake(0, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([collectionView isEqual:self.recipeCategoryCollectionView]){
        return 1;
    }
    else if ([collectionView isEqual:self.recipesCollectionView]){
        return 1;
    }
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.recipeCategoryCollectionView]){
        return self.categoriesArray.count;
    }
    else if ([collectionView isEqual:self.recipesCollectionView]){
        if (self.searchTextField.text.length > 0){
            return self.searchRecipesArray.count;
        }
        else {
            return self.recipesArray.count;
        }
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:self.recipeCategoryCollectionView]){
        RCPCategoryCollectionViewCell *cell = (RCPCategoryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPCategoryCollectionViewCell class]) forIndexPath:indexPath];
        RCPRecipeCategory *category = [self.categoriesArray objectAtIndex:indexPath.row];
        
        cell.categoryNameLabel.text = category.categoryName.length > 0 ? category.categoryName : @"?";
        cell.backgroundColor = [UIColor clearColor];
        //cell.backgroundColor = [UIColor orangeColor];
        
        //cell.categoryImageView.transform = CGAffineTransformIdentity;
        cell.nameAndImageParentView.transform = CGAffineTransformIdentity;
        
        
        if ([self.selectedCategoryIndexPath isEqual:indexPath]){
            //cell.categoryImageView.transform = CGAffineTransformScale(cell.categoryImageView.transform, 1.6, 1.6);
            cell.nameAndImageParentView.transform = CGAffineTransformScale(cell.nameAndImageParentView.transform, 1.4, 1.4);
            
            
            cell.categoryImageView.image = [UIImage imageNamed:category.imageName]; //Set to active image.
            cell.categoryImageView.tintColor = [UIColor colorNamed:@"activeCategoryImageColor"];
            
            cell.categoryNameLabel.font = self.activeCategoryFont;
            cell.categoryNameLabel.textColor = [UIColor colorNamed:@"activeCategoryGrey"];
        }
        else {
            //cell.categoryImageView.transform = CGAffineTransformIdentity;
            cell.nameAndImageParentView.transform = CGAffineTransformIdentity;
            
            
            cell.categoryImageView.image = [UIImage imageNamed:category.imageName]; //Set to active image.
            //cell.categoryImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_inactive", category.imageName]];
            cell.categoryImageView.tintColor = [UIColor colorNamed:@"inactiveCategoryImageColor"];
            
            cell.categoryNameLabel.font = self.inactiveCategoryFont;
            cell.categoryNameLabel.textColor = [UIColor colorNamed:@"inactiveCategoryGrey"];
        }
        
        return cell;
    }
    else {
        RCPRecipeCollectionViewCell *cell = (RCPRecipeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RCPRecipeCollectionViewCell class]) forIndexPath:indexPath];
        
        RCPRecipe *recipe;
        if (self.searchTextField.text.length > 0){
            recipe = [self.searchRecipesArray objectAtIndex:indexPath.row];
        }
        else {
            recipe = [self.recipesArray objectAtIndex:indexPath.row];
        }
        
        //Load recipe name.
        cell.recipeNameLabel.text = recipe.recipeName.length > 0 ? recipe.recipeName : @"";
        cell.recipeNameTextView.text = recipe.recipeName.length > 0 ? recipe.recipeName : @"";
        cell.recipeNameTextView.textContainerInset = UIEdgeInsetsZero;
        cell.recipeNameTextView.textContainer.lineFragmentPadding = 0;
        
        float recipeNameHeightThatFits = MIN([cell.recipeNameTextView sizeThatFits:CGSizeMake(cell.recipeNameTextView.frame.size.width, FLT_MAX)].height, 44);
        //NSLog(@"Fits: %f", recipeNameHeightThatFits);
        cell.recipeNameTextViewHeightConstraint.constant = recipeNameHeightThatFits;
        
        
        cell.favoriteHeartButton.tag = indexPath.row;
        [cell.favoriteHeartButton addTarget:self action:@selector(didToggleRecipeFavorite:) forControlEvents:UIControlEventTouchUpInside];
        cell.favoriteHeartImageView.image = recipe.recipeIsFavorite ? [UIImage imageNamed:@"favHeartRed"] : [UIImage imageNamed:@"favHeartWhite"];
        
        NSInteger rating = recipe.recipeRating;
        cell.ratingNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)rating];
        cell.ratingNumberLabel.hidden = rating > 0 ? NO : YES;
        cell.ratingStarImageView.hidden = rating > 0 ? NO : YES;
        
        //Load recipe image.
        RCPRecipeImage *featuredRecipeImageObject = [[recipe.images.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isFeatured == TRUE"]] firstObject];
        if (featuredRecipeImageObject){
            //Found the featured image - use this one.
            UIImage *recipeImage = [UIImage imageNamed:featuredRecipeImageObject.recipeImageName];
            if (recipeImage){
                cell.recipeImageView.image = recipeImage;
            }
            else {
                NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:featuredRecipeImageObject.recipeImageName];
                cell.recipeImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
            }
        }
        else {
            //No featured image found - default to the first one found.
            RCPRecipeImage *defaultedRecipeImageObject = [recipe.images.allObjects firstObject];
            if (defaultedRecipeImageObject){
                //Found the featured image - use this one.
                UIImage *recipeImage = [UIImage imageNamed:defaultedRecipeImageObject.recipeImageName];
                if (recipeImage){
                    cell.recipeImageView.image = recipeImage;
                }
                else {
                    NSString *imagePathString = [[RCPAppManager sharedInstance] retrievePathForFilenameWithString:defaultedRecipeImageObject.recipeImageName];
                    cell.recipeImageView.image = (imagePathString.length > 0) ? [UIImage imageWithContentsOfFile:imagePathString] : nil;
                }
            }
            else {
                //Load the default 'reciplease' background asset.
                cell.recipeImageView.image = [UIImage imageNamed:@"reciSplashscreen"];
            }
        }
        
        
        
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        //Remove previous sublayers.
        for (CALayer* layer in cell.recipeImageView.layer.sublayers){
            [layer removeFromSuperlayer];
        }
        
        //Add Alpha Gradient over messagePreviewLabel
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        //NSLog(@"Adding gradient at frame: %@", NSStringFromCGRect(gradient.frame));
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor, [UIColor colorWithRed:74/255 green:74/255 blue:74/255 alpha:0], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.77] CGColor], nil];
        gradient.startPoint = CGPointMake(1.0f, 0.0f);
        gradient.endPoint = CGPointMake(1.0f, 1.0f);
        [cell.recipeImageView.layer insertSublayer:gradient atIndex:0];
        
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.recipeCategoryCollectionView]){
        if (!self.performingCollectionCategoryViewAnimations){
            
            
            RCPRecipeCategory *selectedCategory = [self.categoriesArray objectAtIndex:indexPath.row];
            
            //NSLog(@"Selected recipe category: %@", selectedCategory.categoryName);
            self.currentCategoryLabel.text = selectedCategory.categoryName.length > 0 ? selectedCategory.categoryName : @"";
            
            if (![self.selectedCategoryIndexPath isEqual:indexPath]){
                //Selected a new index, perform normal logic.
                if (self.selectedCategoryIndexPath != nil){
                    self.previousCategoryIndexPath = self.selectedCategoryIndexPath;
                }
                self.selectedCategoryIndexPath = indexPath;
                
                RCPCategoryCollectionViewCell *selectedCategoryCell = (RCPCategoryCollectionViewCell*)[self.recipeCategoryCollectionView cellForItemAtIndexPath:self.selectedCategoryIndexPath];
                RCPCategoryCollectionViewCell *previousCategoryCell = (RCPCategoryCollectionViewCell*)[self.recipeCategoryCollectionView cellForItemAtIndexPath:self.previousCategoryIndexPath];
                
                
                //Set image to active for new selection, and set inactive for old selection.
                RCPRecipeCategory *previousCategory = [self.categoriesArray objectAtIndex:self.previousCategoryIndexPath.row];
                
                
                selectedCategoryCell.categoryImageView.image = [UIImage imageNamed:selectedCategory.imageName]; //Set to active image.
                selectedCategoryCell.categoryImageView.tintColor = [UIColor colorNamed:@"activeCategoryImageColor"];
                previousCategoryCell.categoryImageView.image = [UIImage imageNamed:previousCategory.imageName];
                previousCategoryCell.categoryImageView.tintColor = [UIColor colorNamed:@"inactiveCategoryImageColor"];
                
                //previousCategoryCell.categoryImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_inactive", previousCategory.imageName]];
                
                //Set fonts and colors for active vs. inactive
                selectedCategoryCell.categoryNameLabel.font = self.activeCategoryFont;
                selectedCategoryCell.categoryNameLabel.textColor = [UIColor colorNamed:@"activeCategoryGrey"];
                previousCategoryCell.categoryNameLabel.font = self.inactiveCategoryFont;
                previousCategoryCell.categoryNameLabel.textColor = [UIColor colorNamed:@"inactiveCategoryGrey"];
                
                
                
                //Shrink animation for previous cell, if necessary.
                if (previousCategoryCell && previousCategoryCell != selectedCategoryCell){
                    [UIView animateWithDuration:0.3 animations:^{
                        //previousCategoryCell.categoryImageView.transform = CGAffineTransformIdentity;
                        previousCategoryCell.nameAndImageParentView.transform = CGAffineTransformIdentity;
                        
                        
                    } completion:^(BOOL finished) {
                    }];
                }
                
                //Grow animation for the selected category.
                self.performingCollectionCategoryViewAnimations = TRUE;
                [UIView animateWithDuration:0.3 animations:^{
                    //selectedCategoryCell.categoryImageView.transform = CGAffineTransformScale(selectedCategoryCell.categoryImageView.transform, 1.6, 1.6);
                    selectedCategoryCell.nameAndImageParentView.transform = CGAffineTransformScale(selectedCategoryCell.nameAndImageParentView.transform, 1.4, 1.4);
                    
                    
                } completion:^(BOOL finished) {
                    self.performingCollectionCategoryViewAnimations = FALSE;
                    [self.recipeCategoryCollectionView reloadData];
                }];
                
                //Filter the recipes.
                [self filterRecipesBySelectedCategory];
                
            }
            else {
                //Selected the same index, don't do anything in this case.
                //NSLog(@"Selected the same index.  Not performing grow.");
                self.performingCollectionCategoryViewAnimations = FALSE;
                [self.recipeCategoryCollectionView reloadData];
            }
        }
        else {
            //NSLog(@"X - still performing category animations.");
        }
    }
    else if ([collectionView isEqual:self.recipesCollectionView]){
        //NSLog(@"Selected recipe!");
        RCPRecipe *selectedRecipe = [self.recipesArray objectAtIndex:indexPath.row];
        //NSLog(@"Selected Recipe: %@", selectedRecipe.recipeName);
        
        self.selectedRecipe = selectedRecipe;
        [self performSegueWithIdentifier:@"viewRecipeSegue" sender:nil];
    }
}

-(void)filterRecipesBySelectedCategory {
    [self reloadRecipes];
}

#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //NSLog(@"Begin editing.");
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //NSLog(@"End editing.");
}

- (IBAction)searchTextDidChange:(UITextField *)sender {
    //NSLog(@"Search Text: %@", sender.text);
    [self reloadRecipes];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addRecipeSegue"]){
        RCPEditRecipeViewController *editRecipeVC = [segue destinationViewController];
        [[RCPCoreDataManager sharedInstance] setupCreatingRecipeContext];
        RCPRecipe *creatingRecipe = [RCPRecipe MR_createEntityInContext:[RCPCoreDataManager sharedInstance].creatingRecipeContext];
        editRecipeVC.recipe = creatingRecipe;
        editRecipeVC.addingRecipe = YES;
        editRecipeVC.editingRecipe = NO;
        editRecipeVC.delegate = self;
        
        //Create an initial ingredient.
        RCPRecipeIngredient *newRecipeIngredient = [RCPRecipeIngredient MR_createEntityInContext:[RCPCoreDataManager sharedInstance].creatingRecipeContext];
        RCPIngredient *newIngredient = [RCPIngredient MR_createEntityInContext:[RCPCoreDataManager sharedInstance].creatingRecipeContext];
        newRecipeIngredient.ingredient = newIngredient;
        newRecipeIngredient.ingredientNumber = @(1);
        [creatingRecipe addRecipeIngredientsObject:newRecipeIngredient];
        
        //Create an initial instruction (step).
        RCPRecipeInstruction *newInstruction = [RCPRecipeInstruction MR_createEntityInContext:[RCPCoreDataManager sharedInstance].creatingRecipeContext];
        newInstruction.instructionNumber = @(1);
        [creatingRecipe addInstructionsObject:newInstruction];
        
        
    }
    else if ([segue.identifier isEqualToString:@"viewRecipeSegue"]){
        RCPViewRecipeViewController *viewRecipeVC = [segue destinationViewController];
        viewRecipeVC.recipe = self.selectedRecipe;
        viewRecipeVC.delegate = self;
    }
}

#pragma mark - RCPEditRecipeViewControllerDelegate
-(void)recipeWasAdded:(RCPRecipe *)addedRecipe {
    //NSLog(@"Home VC: recipeWasAdded: %@", addedRecipe.recipeName);
    [self reloadRecipes];
    [self reloadCategories];
}

-(void)recipeWasDeleted {
    //NSLog(@"Home VC: recipeWasDeleted");
    [self reloadRecipes];
    [self reloadCategories];
}

-(void)recipeViewCanceled {
    //NSLog(@"Home VC: recipeViewCanceled");
    [self reloadRecipes];
    [self reloadCategories];
}

#pragma mark - RCPViewRecipeViewControllerDelegate
-(void)recipeClosed:(RCPRecipe *)recipe {
    //NSLog(@"Home VC: recipeClosed: %@", recipe.recipeName);
    [self reloadCategories];
    [self reloadRecipes];
}

#pragma mark - NSNotifications
-(void)detectedCategoryDeleted:(NSNotification*)notification {
    
    RCPRecipeCategory *currentCategory = [self.categoriesArray objectAtIndex:self.selectedCategoryIndexPath.row];
    NSString *detectedDeletedCategory = [notification.userInfo valueForKey:@"categoryName"];
    if ([currentCategory.categoryName isEqualToString:detectedDeletedCategory]){
        //Default back to 'ALL' category.
        self.selectedCategoryIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self reloadCategories];
        [self reloadRecipes];
    }
    else {
        //NSLog(@"Wasn't the deleted category.");
    }
}

#pragma mark - Testing

- (IBAction)testButtonTapped:(UIButton *)sender {
    //NSLog(@"reloading");
    
    
    [self.recipesCollectionView reloadData];
    
    

    
}

@end
