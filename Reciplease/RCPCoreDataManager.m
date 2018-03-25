//
//  RCPCoreDataManager.m
//  Reciplease
//
//  Created by Daniel Yessayian on 8/19/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import "RCPCoreDataManager.h"

@implementation RCPCoreDataManager

+ (instancetype)sharedInstance {
    static RCPCoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    }); return sharedInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        //Initialization
    } return self;
}

-(void)createCategories {
    //Create Recipe Categories - or update existing ones if they already exist.
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"InitialCategoriesCreated"]) {
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@0, @"categoryName":@"All", @"imageName":@"category_final_57"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@1, @"categoryName":@"American", @"imageName":@"category_final_66"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@2, @"categoryName":@"Chinese", @"imageName":@"category_final_89"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@3, @"categoryName":@"Cocktails", @"imageName":@"category_final_61"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@4, @"categoryName":@"French", @"imageName":@"category_final_40"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@5, @"categoryName":@"Italian", @"imageName":@"category_final_139"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@6, @"categoryName":@"Japanese", @"imageName":@"category_final_148"}];
        [RCPRecipeCategory buildRCPRecipeCategoryWithDictionary:@{@"categoryID":@7, @"categoryName":@"Mexican", @"imageName":@"category_final_149"}];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"InitialCategoriesCreated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        //NSLog(@"Already created initial categories.");
    }
}

#pragma mark - RecipePack1
-(void)createRecipePackOneRecipes {
    //These recipes will be added with the initial upload of the application.  Any further packs will be released as updates.
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"RecipePackOneRecipesCreated"]) {
        [self createCreamyScallopSpaghettiRecipe];
        [self createBreadLoafDipRecipe];
        [self createSweetAndSourPorkRecipe];
        [self createStrawberryJelloSaladRecipe];
        [self createPeanutButterChocolateKissCookiesRecipe];
        [self createPestoCheeseBlossomRecipe];
        [self createGulliversCornRecipe];
        [self createCrepesWithAppleCompoteRecipe];
        [self createPalmiersRecipe];
        [self createChocolatePeanutButterBallsRecipe];
        [self createZuppaToscanaRecipe];
        [self createChickenAndDumplingsRecipe];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RecipePackOneRecipesCreated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"Already created initial recipes.");
    }
}


-(void)createCreamyScallopSpaghettiRecipe {
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Creamy Scallop Spaghetti"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Creamy Scallop Spaghetti";
        testingRecipe1.recipeNotes = @"Here are notes for the creamy scallop spaghetti.";
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"8";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"thick spaghetti";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"1";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"vegetable oil";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePound];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"bay scallops";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"2";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"butter";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"3";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeClove];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"garlic";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"2";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"lemon zest";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"1";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"red pepper flakes";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"1/3";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"dry sherry";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"heavy cream";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"1";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"salt";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient11 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient11.ingredientQuantity = @"1";
        recipeingredient11.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient11.ingredientNumber = @10;
        RCPIngredient *ingredient11 = [RCPIngredient MR_createEntity];
        ingredient11.ingredientName = @"pepper";
        [ingredient11 addRecipeIngredientObject:recipeingredient11];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient12 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient12.ingredientQuantity = @"1";
        recipeingredient12.ingredientMeasurement = @"";
        recipeingredient12.ingredientNumber = @11;
        RCPIngredient *ingredient12 = [RCPIngredient MR_createEntity];
        ingredient12.ingredientName = @"lemon";
        [ingredient12 addRecipeIngredientObject:recipeingredient12];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient13 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient13.ingredientQuantity = @"2";
        recipeingredient13.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient13.ingredientNumber = @12;
        RCPIngredient *ingredient13 = [RCPIngredient MR_createEntity];
        ingredient13.ingredientName = @"italian parsley";
        [ingredient13 addRecipeIngredientObject:recipeingredient13];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient14 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient14.ingredientQuantity = @"";
        recipeingredient14.ingredientMeasurement = @"";
        recipeingredient14.ingredientNumber = @13;
        RCPIngredient *ingredient14 = [RCPIngredient MR_createEntity];
        ingredient14.ingredientName = @"Parmigiano-Reggiano";
        [ingredient14 addRecipeIngredientObject:recipeingredient14];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Bring a large pot of lightly salted water to a boil. Cook spaghetti in the boiling water, stirring occasionally until tender yet firm to the bite, about 10 minutes or 1 minute less than directed on the package.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Heat oil in a large skillet over high heat. When oil just starts to smoke, add scallops and move them into a single layer. Let sear on high for 60 seconds. Toss to turn. Add butter and stir scallops until butter melts. Stir in minced garlic. Add lemon zest and red pepper flakes. Stir in sherry and cook and stir until alcohol cooks off, about 1 minute. Pour in cream. When mixture begins to simmer, reduce heat to medium-low. Add salt, pepper, and lemon juice.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"Drain pasta. Transfer to skillet with scallops; bring to a simmer. Add half the parsley. Cook until pasta is heated through and tender, about 1 minute. Remove from heat. Grate generously with grated cheese. Add the rest of the parsley. Serve in warm bowls.";
        
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        RCPRecipeCategory *recipeCategory2 = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"Italian"];
        if (recipeCategory2){
            [recipeCategory2 addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"pasta";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"creamy";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"seafood";
        tag3.tagNumber = @2;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"scallop";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10, recipeingredient11, recipeingredient12, recipeingredient13, recipeingredient14]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Creamy Scallop Spaghetti already exists!");
    }
}

-(void)createBreadLoafDipRecipe {
    
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Bread Loaf Dip"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Bread Loaf Dip";
        testingRecipe1.recipeNotes = @"Recipe from Vicki.";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"8";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"cream cheese";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"1";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"jack cheese (grated)";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"sour cream";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"4";
        recipeingredient4.ingredientMeasurement = @"";
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"green onions (minced)";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"4";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"dried, chipped beef";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"3";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"Worcestershire sauce";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Mix all ingredients. Place in hollowed out bread loaf (round Italian or round bakery loaf) and set aside the removed bread.  Bake the loaf at 350 degrees for 45 minutes.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Cube the bread that was removed to hollow out the loaf.  During the last 30 minutes, toast them in the oven until golden brown and crispy (keep an eye on them and remove early, if necessary).  Toasted bread cubes are dipped into the loaf dip.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"appetizer";
        tag1.tagNumber = @0;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"breadloafdip";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Bread Loaf Dip already exists!");
    }
}

-(void)createSweetAndSourPorkRecipe {
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Sweet and Sour Pork"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Sweet and Sour Pork";
        testingRecipe1.recipeNotes = @"I always marinade for hours before cooking. I do believe this is the key to having the ribs fall off the bone tender! I just use a large bottle of Kikkoman Teriyaki Marinade and Sauce, but I am sure other marines are fine.";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"";
        recipeingredient1.ingredientMeasurement = @"";
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"Country-Style Ribs";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"2.5";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"canned pineapple chunks";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1/4";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"brown sugar";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"2";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"cornstarch";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"1/4";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"vinegar";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"3";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"soy sauce";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"1/2";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"salt";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"1";
        recipeingredient8.ingredientMeasurement = @"";
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"small green pepper - cut into strips";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1/4";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"thinly sliced onion";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Brown ribs in small amount of hot fat.  Add 1/2 cup water.  Cover and simmer until tender.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Drain pineapple, reserving syrup.  Combine sugar and cornstarch, add pineapple syrup, vinegar, soy sauce, and salt.  Add to pork.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"Cook and stir until gravy thickens.  Add pineapple, green pepper, and onion.  Cook 2-3 minutes.  Serve over hot fluffy rice and pass extra soy sauce.";
        
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"savory";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"holidays";
        tag2.tagNumber = @1;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"SweetAndSourPork";
        recipeImage1.isFeatured = YES;
        
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Sweet and Sour Pork recipe already exists!");
    }
}

-(void)createStrawberryJelloSaladRecipe {
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Strawberry Jello Salad"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Strawberry Jello Salad";
        testingRecipe1.recipeNotes = @"Allow plenty of time for the jello to thicken, do not pour over second layer until thick. (You may want to make this recipe the day/night before serving).";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"2";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"pretzels (crushed)";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"3";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"sugar";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"3/4";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"melted butter";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"8";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"cream cheese";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"1/2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"powdered sugar";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"1";
        recipeingredient6.ingredientMeasurement = @"";
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"large carton of cool whip";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"2";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"miniature marshmallows";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"6";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"strawberry jello";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"2.5";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"boiling water";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"11";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"frozen strawberries";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Mix together pretzels, sugar, and butter. Press into a 9\" x 13\" pan.  Bake at 350 degrees for 15 minutes.  Set aside to cool.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Blend together the cream cheese and powdered sugar. Fold in the cool whip and marshmallows.  Spread over the pretzel layer.  Refrigerate.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"Dissolve the jello in boiling water. Stir in the strawberries.  Chill until thickened.  Stir again.  Pour over cheese layer.  Chill until firm.";
        
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"dessert";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"layered";
        tag2.tagNumber = @0;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"StrawberryPretzelSalad";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Strawberry Jello Salad recipe already exists!");
    }
}

-(void)createPeanutButterChocolateKissCookiesRecipe {
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Peanut Butter Chocolate Kiss Cookies"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Peanut Butter Chocolate Kiss Cookies";
        testingRecipe1.recipeNotes = @"";
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"2-2/3";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"all-purpose flour";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"2";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"baking soda";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"salt";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"butter";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"2/3";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"creamy peanut butter (room temp)";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"1";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"sugar";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"1";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"brown sugar (firmly packed)";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"2";
        recipeingredient8.ingredientMeasurement = @"";
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"eggs";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"2";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"vanilla";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"60";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePiece];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"foil-wrapped chocolate Kisses";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Preheat oven to 375 degrees. Mix flour with baking soda and salt.  Set aside.  In a large bowl with electric mixer at medium speed, beat butter and peanut butter together until well blended.  Add 1 cup sugar and brown sugar.  Beat until light and fluffy.  Add eggs and vanilla.  Beat until smooth.  Stir in flour mixture until well combined.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Using level tablespoon for each, shape into 5 dozen balls. Roll each in sugar. Place 2\" apart on ungreased cookie sheets.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"Bake 8 minutes. Remove from oven. Press an unwrapped chocolate Kiss on top of each. Bake 2 minutes longer. Remove cookies to wire rack and let cool completely.";
        
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"chocolate";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"peanut butter";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"dessert";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"cookie";
        tag4.tagNumber = @2;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"peanutbutterhersheykiss";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Peanut Butter Chocolate Kiss Cookies recipe already exists!");
    }
}

-(void)createPestoCheeseBlossomRecipe {
    
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Pesto Cheese Blossom"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Pesto Cheese Blossom";
        testingRecipe1.recipeNotes = @"Recipe from Paula Deen";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"8";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"provolone cheese (sliced)";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"16";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"cream cheese (room temperature)";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"20";
        recipeingredient3.ingredientMeasurement = @"";
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"pistachios (shelled)";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"2";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeClove];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"garlic";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"1/2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"fresh basil leaves";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"1/2";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"fresh parsley leaves";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"1/2";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"pine nuts";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"1/4";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"salt";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1/4";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"pepper";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"2";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"extra-virgin olive oil";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient11 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient11.ingredientQuantity = @"3";
        recipeingredient11.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient11.ingredientNumber = @10;
        RCPIngredient *ingredient11 = [RCPIngredient MR_createEntity];
        ingredient11.ingredientName = @"oil-packed sun-dried tomatoes";
        [ingredient11 addRecipeIngredientObject:recipeingredient11];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Line a bowl with plastic wrap, and leave enough overhang to cover the top later. Set aside 3 slices of the provolone, and use the rest to line the bottom and sides of the bowl, overlapping the slices.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"For the cream cheese layer, process the cream cheese, pistachios, and one garlic clove in a food processor. Scrape the mixture into a bowl and set aside.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"For the pesto layer, process the basil, parsley, pine nuts, and remaining garlic clove. Dissolve the salt and pepper into the olive oil and mix well.  While the food processor is running, add the oil in a stream.  Scrape the mixture into a second bowl and set aside.";
        
        RCPRecipeInstruction *recipeInstruction4 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction4.instructionNumber = @4;
        recipeInstruction4.instructionText = @"For the tomato layer, drain the tomatoes, reserving the oil. Puree the tomatoes with a small amount of the reserved oil in a food processor. Scrape the mixture into a third bowl and set aside.";
        
        RCPRecipeInstruction *recipeInstruction5 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction5.instructionNumber = @5;
        recipeInstruction5.instructionText = @"Spread some of the cream cheese mixture over the cheese slices lining the bowl.  Layer the pesto mixture, then half of the remaining cream cheese mixture, then the sun-dried tomato mixture, and finally the remaining cream cheese mixture into the bowl.  Cover with the last 3 pieces of provolone.  Use the overhaning plastic wrap to cover. Refrigerate until ready to use, or freeze if desired.  When ready to serve, remove plastic wrap and flip right-side up.  Serve with party crackers.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"cheese";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"pesto";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"dip";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"holidays";
        tag4.tagNumber = @3;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"PestoCheeseBlossom";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10, recipeingredient11]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3, recipeInstruction4, recipeInstruction5]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Pesto Cheese Blossom recipe already exists!");
    }
}

-(void)createGulliversCornRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Gulliver's Corn"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Gulliver's Corn";
        testingRecipe1.recipeNotes = @"You can use different types of corn.  Taste before serving, add more salt/sugar/cayenne if desired.";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"40";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"frozen white corn";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"8";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"whipping cream";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"8";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"milk";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"salt";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"sugar";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"pepper";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"cayenne pepper";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"2";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"butter (melted)";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"2";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"flour";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Set the flour and butter aside, and combine all other ingredients in a pot.  Bring to a boil, then turn down heat to a simmer for 5 minutes.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Blend the flour and melted butter together to form a paste.  Add to the corn.  Mix well, and remove from heat.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"creamy";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"corn";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"spicy";
        tag3.tagNumber = @2;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"GulliversCorn2";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Gulliver's Corn recipe already exists!");
    }
}

-(void)createCrepesWithAppleCompoteRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Crepes with Apple Compote"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Crepes with Apple Compote";
        testingRecipe1.recipeNotes = @"";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"2";
        recipeingredient1.ingredientMeasurement = @"";
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"apples - peeled, cored, thinly sliced";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"1";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"lemon juice";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1/3";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"sugar";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1/2";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"vanilla";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"1/2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"cinnamon";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"1-1/2";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"flour";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"1";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"sugar (for crepe batter)";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"1/2";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"baking powder";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1/2";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"salt (for crepe batter)";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"2";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"milk";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient11 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient11.ingredientQuantity = @"2";
        recipeingredient11.ingredientMeasurement = @"";
        recipeingredient11.ingredientNumber = @10;
        RCPIngredient *ingredient11 = [RCPIngredient MR_createEntity];
        ingredient11.ingredientName = @"eggs";
        [ingredient11 addRecipeIngredientObject:recipeingredient11];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient12 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient12.ingredientQuantity = @"1/2";
        recipeingredient12.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient12.ingredientNumber = @11;
        RCPIngredient *ingredient12 = [RCPIngredient MR_createEntity];
        ingredient12.ingredientName = @"vanilla (for crepe batter)";
        [ingredient12 addRecipeIngredientObject:recipeingredient12];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient13 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient13.ingredientQuantity = @"2";
        recipeingredient13.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTablespoon];
        recipeingredient13.ingredientNumber = @12;
        RCPIngredient *ingredient13 = [RCPIngredient MR_createEntity];
        ingredient13.ingredientName = @"butter or oil";
        [ingredient13 addRecipeIngredientObject:recipeingredient13];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"For the apple compote: In a bowl, combine apples and lemon juice.  In a saute pan, combine the sugar, 3 tablspoons of apple juice, and the vanilla, bring to a boil. Cook without stirring until the mixture thickens and begins to caramelize. Add apples and juices, remaining apple juice, and cinnamon. Cook over medium heat, stirring occasionally, until apples are tender and translucent and the liquid is thick (~20 minutes).";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"For the crepes: mix flour, sugar, baking powder, and salt into bowl. Stir in remaining ingredients. Beat with beater until smooth. For each crepe, lightly butter 8 inch skillet, heat over medium until butter is bubbly. Pour scant 1/4 cup of batter into skillet, immediately rotate pan until batter covers bottom. Cook until light brown, turn and brown on other side. Once done, crepes can be moved to a plate and topped with some of the apple compote. If desired, you can serve with whipped cream, extra sprinkled cinnamon, powdered sugar, etc.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        RCPRecipeCategory *recipeCategory2 = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"French"];
        if (recipeCategory2){
            [recipeCategory2 addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"apple";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"dessert";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"breakfast";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"cinnamon";
        tag4.tagNumber = @3;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"Crepes";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10, recipeingredient11, recipeingredient12, recipeingredient13]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Crepes with Apple Compote recipe already exists!");
    }
}

-(void)createPalmiersRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Palmiers"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Palmiers";
        testingRecipe1.recipeNotes = @"";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"2";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"sugar";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"1/8";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"kosher salt";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"cinnamon";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePinch];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"ground nutmeg";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeSheet];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"puff pastry (defrosted)";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Preheat the oven to 450 degrees F.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Combine the sugar, kosher salt, cinnamon, and nutmug.  Pour one cup of the mixture on a flat working surface. Unfold each sheet of puff pastry onto the sugar and pour 1/2 cup of the sugar mixture on top. Spread it evenly on the puff pastry for an even coating of sugar. With a rolling pin, roll the dough until it is around a 13 x 13 inch square, and the sugar is pressed into the puff pastry on both top and bottom.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"Fold the sides of the square towards the center so they go halfway to the middle. Fold them again so the two folds meet exactly at the middle of the dough. Then, fold 1 half over the other as though closing a book. You will now have 6 layers. Slice the dough into 3/8-inch slices and place the slices, cut side up, on baking sheets lined with parchment paper. Place the second sheet of pastry on the sugared board, and repeat this process. You will likely have extra sugar mixture after the process.";
        
        RCPRecipeInstruction *recipeInstruction4 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction4.instructionNumber = @4;
        recipeInstruction4.instructionText = @"Bake the cookies for 6 minutes until caramelized and brown on the bottom, then turn with a spatula and bake another 3-5 minutes, until caramelized on the other side. Transfer to a baking rack to cool.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        RCPRecipeCategory *recipeCategory2 = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"French"];
        if (recipeCategory2){
            [recipeCategory2 addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"crunchy";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"pastry";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"dessert";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"cinnamon";
        tag4.tagNumber = @3;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"Palmiers";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3, recipeInstruction4]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Palmiers recipe already exists!");
    }
}

-(void)createChocolatePeanutButterBallsRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Chocolate Peanut Butter Balls"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Chocolate Peanut Butter Balls";
        testingRecipe1.recipeNotes = @"";
        
        //        16 ounces of peanut butter
        //        3 cups of rice krispies
        //        1 stick butter (melted)
        //        1 box powdered sugar
        //        [chocolate]
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"16";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"peanut butter";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"3";
        recipeingredient2.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"rice krispies";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1/2";
        recipeingredient3.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"butter";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1";
        recipeingredient4.ingredientMeasurement = @"";
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"box of powdered sugar";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"";
        recipeingredient5.ingredientMeasurement = @"";
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"chocolate for melting (semisweet or bittersweet, preferably)";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Mix all ingredients together, except for the chocolate. Form into balls of desired size.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Melt the chocolate over a double boiler. Drop one formed peanut butter ball in the melted chocolate and roll around until completely coated. Remove and place onto a baking sheet lined with wax or parchment paper. Don't place them too close together, or the chocolate peanut butter balls may stick together.  Once the baking sheet is filled, place in the fridge to allow the balls to solidify.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"chocolate";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"peanut butter";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"crunchy";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"dessert";
        tag4.tagNumber = @3;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"ChocolatePeanutButterBalls";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Chocolate Peanut Butter Balls recipe already exists!");
    }
}

-(void)createZuppaToscanaRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Zuppa Toscana"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Zuppa Toscana";
        testingRecipe1.recipeNotes = @"I prefer mine to be spicier, so I typically get hot italian sausage, and/or add red pepper flakes to the italian sausage while it cooks in the pan.  If you plan on having leftovers, you may want to only add the kale to individual bowls instead of to the pot directly, to prevent the kale from wilting.";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"1";
        recipeingredient1.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypePound];
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"italian sausage";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"2";
        recipeingredient2.ingredientMeasurement = @"";
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"russet potatoes - thinly sliced";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1";
        recipeingredient3.ingredientMeasurement = @"";
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"large onion - chopped";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1/4";
        recipeingredient4.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"Optional: bacon bits";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"2";
        recipeingredient5.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeClove];
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"garlic - minced";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"2";
        recipeingredient6.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"kale - chopped";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"16";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeOunce];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"chicken broth";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"1";
        recipeingredient8.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeQuart];
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"water";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"heavy whipping cream";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"1";
        recipeingredient10.ingredientMeasurement = @"";
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"Optional: baguette or other desired bread";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Cook sausage in a large pot. Break apart into small pieces as it cooks. When done cooking, remove the sausage from the pan, but leave any remaining fond.  If desired, drain off any excess oil from the sausage.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"Add the chicken broth and water to the pot that the sausage was cooked in. Add the onions, potatoes, and garlic. Cook over medium heat until the potatoes are cooked through. Once the potatoes are cooked, add the sausage (and bacon, if desired) back to the pot. Allow to simmer for 10 more minutes, adding salt and pepper to taste. Turn to low heat, add the chopped kale and cream. Heat through briefly then remove from heat and serve.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        RCPRecipeCategory *recipeCategory2 = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"Italian"];
        if (recipeCategory2){
            [recipeCategory2 addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"soup";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"sausage";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"potato";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"onion";
        tag4.tagNumber = @3;
        
        RCPRecipeTag *tag5 = [RCPRecipeTag MR_createEntity];
        tag5.tagString = @"kale";
        tag5.tagNumber = @4;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"ZuppaToscana";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4, tag5]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Zuppa Toscana recipe already exists!");
    }
}

-(void)createChickenAndDumplingsRecipe{
    RCPRecipe *testingRecipe1 = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Chicken and Dumplings"];
    if (!testingRecipe1){
        testingRecipe1 = [RCPRecipe MR_createEntity];
        testingRecipe1.recipeName = @"Chicken and Dumplings";
        testingRecipe1.recipeNotes = @"You can add more or less of the onions, celery, and carrots.";
        
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient1 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient1.ingredientQuantity = @"1";
        recipeingredient1.ingredientMeasurement = @"";
        recipeingredient1.ingredientNumber = @0;
        RCPIngredient *ingredient1 = [RCPIngredient MR_createEntity];
        ingredient1.ingredientName = @"whole raw chicken (~3-4 lbs)";
        [ingredient1 addRecipeIngredientObject:recipeingredient1];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient2 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient2.ingredientQuantity = @"1";
        recipeingredient2.ingredientMeasurement = @"";
        recipeingredient2.ingredientNumber = @1;
        RCPIngredient *ingredient2 = [RCPIngredient MR_createEntity];
        ingredient2.ingredientName = @"onion - cubed";
        [ingredient2 addRecipeIngredientObject:recipeingredient2];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient3 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient3.ingredientQuantity = @"1";
        recipeingredient3.ingredientMeasurement = @"";
        recipeingredient3.ingredientNumber = @2;
        RCPIngredient *ingredient3 = [RCPIngredient MR_createEntity];
        ingredient3.ingredientName = @"large celery rib - cubed";
        [ingredient3 addRecipeIngredientObject:recipeingredient3];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient4 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient4.ingredientQuantity = @"1";
        recipeingredient4.ingredientMeasurement = @"";
        recipeingredient4.ingredientNumber = @3;
        RCPIngredient *ingredient4 = [RCPIngredient MR_createEntity];
        ingredient4.ingredientName = @"large carrot, cubed";
        [ingredient4 addRecipeIngredientObject:recipeingredient4];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient5 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient5.ingredientQuantity = @"1";
        recipeingredient5.ingredientMeasurement = @"";
        recipeingredient5.ingredientNumber = @4;
        RCPIngredient *ingredient5 = [RCPIngredient MR_createEntity];
        ingredient5.ingredientName = @"bay leaf";
        [ingredient5 addRecipeIngredientObject:recipeingredient5];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient6 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient6.ingredientQuantity = @"4";
        recipeingredient6.ingredientMeasurement = @"";
        recipeingredient6.ingredientNumber = @5;
        RCPIngredient *ingredient6 = [RCPIngredient MR_createEntity];
        ingredient6.ingredientName = @"sprigs of thyme";
        [ingredient6 addRecipeIngredientObject:recipeingredient6];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient7 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient7.ingredientQuantity = @"2.5";
        recipeingredient7.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeQuart];
        recipeingredient7.ingredientNumber = @6;
        RCPIngredient *ingredient7 = [RCPIngredient MR_createEntity];
        ingredient7.ingredientName = @"water";
        [ingredient7 addRecipeIngredientObject:recipeingredient7];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient8 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient8.ingredientQuantity = @"";
        recipeingredient8.ingredientMeasurement = @"";
        recipeingredient8.ingredientNumber = @7;
        RCPIngredient *ingredient8 = [RCPIngredient MR_createEntity];
        ingredient8.ingredientName = @"salt, pepper, and cayenne - to taste";
        [ingredient8 addRecipeIngredientObject:recipeingredient8];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient9 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient9.ingredientQuantity = @"1/2";
        recipeingredient9.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient9.ingredientNumber = @8;
        RCPIngredient *ingredient9 = [RCPIngredient MR_createEntity];
        ingredient9.ingredientName = @"creme fraiche (or sour cream, if unavailable)";
        [ingredient9 addRecipeIngredientObject:recipeingredient9];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient10 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient10.ingredientQuantity = @"1/2";
        recipeingredient10.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient10.ingredientNumber = @9;
        RCPIngredient *ingredient10 = [RCPIngredient MR_createEntity];
        ingredient10.ingredientName = @"milk";
        [ingredient10 addRecipeIngredientObject:recipeingredient10];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient11 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient11.ingredientQuantity = @"2";
        recipeingredient11.ingredientMeasurement = @"";
        recipeingredient11.ingredientNumber = @10;
        RCPIngredient *ingredient11 = [RCPIngredient MR_createEntity];
        ingredient11.ingredientName = @"eggs";
        [ingredient11 addRecipeIngredientObject:recipeingredient11];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient12 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient12.ingredientQuantity = @"2";
        recipeingredient12.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeTeaspoon];
        recipeingredient12.ingredientNumber = @11;
        RCPIngredient *ingredient12 = [RCPIngredient MR_createEntity];
        ingredient12.ingredientName = @"fresh chopped thyme leaves";
        [ingredient12 addRecipeIngredientObject:recipeingredient12];
        
        //Ingredient
        RCPRecipeIngredient *recipeingredient13 = [RCPRecipeIngredient MR_createEntity];
        recipeingredient13.ingredientQuantity = @"2";
        recipeingredient13.ingredientMeasurement = [[RCPAppManager sharedInstance] stringWithEnum:RCPRecipeIngredientMeasurementTypeCup];
        recipeingredient13.ingredientNumber = @12;
        RCPIngredient *ingredient13 = [RCPIngredient MR_createEntity];
        ingredient13.ingredientName = @"self-rising flour";
        [ingredient13 addRecipeIngredientObject:recipeingredient13];
        
        
        //Instructions
        RCPRecipeInstruction *recipeInstruction1 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction1.instructionNumber = @1;
        recipeInstruction1.instructionText = @"Add the whole raw chicken, celery, carrots, and onion to a large pot. Add 2.5 quarts of cold water, the bay leaf, and the sprigs of thyme.  Heat on high, bring to a boil. Once boiling, lower to a simmer. Cover, and cook for 1 hour.";
        
        RCPRecipeInstruction *recipeInstruction2 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction2.instructionNumber = @2;
        recipeInstruction2.instructionText = @"After an hour, take the chicken out and place into a bowl to cool. While the chicken cools, turn the heat back to high on the stock to boil. Ladle of 2 tbsp of chicken fat, and add an equal amount of flour to make a paste. Add a couple tablespoons of the hot stock and stir, then whisk the mixture back into the soup. Lower the heat, and simmer for about 15 minutes. During this time, remove the meat off the chicken, if cool enough.  Once all the meat has been removed, add the meat into the pot and discard the rest of the carcass. Add salt, cayenne, and ground black pepper to taste. Leave on low heat for 10-15 minutes more while you make the dumpling batter.";
        
        RCPRecipeInstruction *recipeInstruction3 = [RCPRecipeInstruction MR_createEntity];
        recipeInstruction3.instructionNumber = @3;
        recipeInstruction3.instructionText = @"For the dumpling batter, mix together the creme fraiche, milk, thyme leaves, and eggs. Then, add the self rising flour with a wooden spoon until just incorporated - do not overmix. Add large dollops of the batter to the top of the simmering soup. Cover, and allow the dumplings to steam for ~10-12 minutes.";
        
        //Categories
        RCPRecipeCategory *recipeCategory = [RCPRecipeCategory MR_findFirstByAttribute:@"categoryName" withValue:@"American"];
        if (recipeCategory){
            [recipeCategory addRecipesObject:testingRecipe1];
        }
        
        //Tags
        RCPRecipeTag *tag1 = [RCPRecipeTag MR_createEntity];
        tag1.tagString = @"soup";
        tag1.tagNumber = @0;
        
        RCPRecipeTag *tag2 = [RCPRecipeTag MR_createEntity];
        tag2.tagString = @"chicken";
        tag2.tagNumber = @1;
        
        RCPRecipeTag *tag3 = [RCPRecipeTag MR_createEntity];
        tag3.tagString = @"carrot";
        tag3.tagNumber = @2;
        
        RCPRecipeTag *tag4 = [RCPRecipeTag MR_createEntity];
        tag4.tagString = @"onion";
        tag4.tagNumber = @3;
        
        RCPRecipeTag *tag5 = [RCPRecipeTag MR_createEntity];
        tag5.tagString = @"celery";
        tag5.tagNumber = @3;
        
        RCPRecipeTag *tag6 = [RCPRecipeTag MR_createEntity];
        tag6.tagString = @"dumplings";
        tag6.tagNumber = @4;
        
        //Images
        RCPRecipeImage *recipeImage1 = [RCPRecipeImage MR_createEntity];
        recipeImage1.recipeImageName = @"ChickenAndDumplings";
        recipeImage1.isFeatured = YES;
        
        //Set relationships.
        [testingRecipe1 addRecipeIngredients:[NSSet setWithArray:@[recipeingredient1, recipeingredient2, recipeingredient3, recipeingredient4, recipeingredient5, recipeingredient6, recipeingredient7, recipeingredient8, recipeingredient9, recipeingredient10, recipeingredient11, recipeingredient12, recipeingredient13]]];
        
        [testingRecipe1 addInstructions:[NSSet setWithArray:@[recipeInstruction1, recipeInstruction2, recipeInstruction3]]];
        
        [testingRecipe1 addTags:[NSSet setWithArray:@[tag1, tag2, tag3, tag4, tag5, tag6]]];
        
        [testingRecipe1 addImages:[NSSet setWithArray:@[recipeImage1]]];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    else {
        //Already have this recipe.
        //NSLog(@"Chicken and Dumplings recipe already exists!");
    }
}

#pragma mark - Contexts
-(void)setupCreatingRecipeContext {
    if (!self.creatingRecipeContext){
        self.creatingRecipeContext = [NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]];
    }
    else {
        //NSLog(@"Creating recipe context already exists.");
    }
}

#pragma mark - Build #2
-(void)applyBuild2Patch {
    
    //For Build 2, making some fixes to some recipes.
    
    //For Bread Loaf Dip:
    // -> Change the recipeInstruction with ID: 2
    NSString *breadLoafInstruction2OldText = @"Cube the bread that was removed to hollow out the loaf.  During the last 30 minutes, toast them in the oven until golden brown and crispy.  Toasted bread cubes are dipped into the loaf dip.";
    NSString *breadLoafInstruction2NewText = @"Cube the bread that was removed to hollow out the loaf.  During the last 30 minutes, toast them in the oven until golden brown and crispy (keep an eye on them and remove early, if necessary).  Toasted bread cubes are dipped into the loaf dip.";
    RCPRecipe *breadLoafDipRecipe = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Bread Loaf Dip"];
    RCPRecipeInstruction *breadLoafInstruction2 = [[breadLoafDipRecipe.instructions.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"instructionNumber == %@", @2]] firstObject];
    if (breadLoafDipRecipe && breadLoafInstruction2 && [breadLoafInstruction2.instructionText isEqualToString:breadLoafInstruction2OldText]){
        NSLog(@"Updating bread loaf instruction #2.");
        breadLoafInstruction2.instructionText = breadLoafInstruction2NewText;
    }
    else {
        NSLog(@"Either recipe was deleted or already changed, don't need to update.");
    }
    
    //For Chocolate Peanut Butter Balls:
    // -> Change the recipeInstruction with ID: 2
    NSString *cpbbInstruction2OldText = @"Melt the chocolate over a double boiler. Drop one formed peanut butter ball in the melted chocolate and roll around until completely coated. Remove and place onto a baking sheet lined with wax or parchment paper. Don't place them too close together, or the chocolate peanut butter balls may stick together.  Once the baking sheet is filled, place either in the fridge to allow the balls to solidify.";
    NSString *cpbbInstruction2NewText = @"Melt the chocolate over a double boiler. Drop one formed peanut butter ball in the melted chocolate and roll around until completely coated. Remove and place onto a baking sheet lined with wax or parchment paper. Don't place them too close together, or the chocolate peanut butter balls may stick together.  Once the baking sheet is filled, place in the fridge to allow the balls to solidify.";
    RCPRecipe *chocolatePeanutButterBallRecipe = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Chocolate Peanut Butter Balls"];
    RCPRecipeInstruction *cpbbInstruction2 = [[chocolatePeanutButterBallRecipe.instructions.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"instructionNumber == %@", @2]] firstObject];
    if (chocolatePeanutButterBallRecipe && cpbbInstruction2 && [cpbbInstruction2.instructionText isEqualToString:cpbbInstruction2OldText]){
        NSLog(@"Updating chocolate peanut butter balls instruction #2.");
        cpbbInstruction2.instructionText = cpbbInstruction2NewText;
    }
    else {
        NSLog(@"Either recipe was deleted or already changed, don't need to update.");
    }
    
    //For Strawberry Jello Salad:
    // -> Change the notes (previously blank). Update 'dream whip' to 'cool whip' (both an ingredient and instruction).
    RCPRecipe *strawberryJelloSaladRecipe = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Strawberry Jello Salad"];
    if (strawberryJelloSaladRecipe){
        
        //Update the notes.
        if (strawberryJelloSaladRecipe.recipeNotes.length == 0){
            strawberryJelloSaladRecipe.recipeNotes = @"Allow plenty of time for the jello to thicken, do not pour over second layer until thick. (You may want to make this recipe the day/night before serving).";
        }
        
        //Update ingredient 'dream whip' (ID: 5) to 'cool whip'.
        RCPRecipeIngredient *previousDreamWhipIngredient = [[strawberryJelloSaladRecipe.recipeIngredients.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ingredientNumber == %@", @5]] firstObject];
        if (previousDreamWhipIngredient && [previousDreamWhipIngredient.ingredient.ingredientName isEqualToString:@"large carton of dream whip"]){
            previousDreamWhipIngredient.ingredient.ingredientName = @"large carton of cool whip";
        }
        
        //Update instruction including 'dream whip' (ID: 2) text to 'cool whip'.
        RCPRecipeInstruction *dreamWhipInstruction2 = [[strawberryJelloSaladRecipe.instructions.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"instructionNumber == %@", @2]] firstObject];
        NSString *dreamWhipInstruction2OldText = @"Blend together the cream cheese and powdered sugar. Fold in the dream whip and marshmallows.  Spread over the pretzel layer.  Refrigerate.";
        NSString *dreamWhipInstruction2NewText = @"Blend together the cream cheese and powdered sugar. Fold in the cool whip and marshmallows.  Spread over the pretzel layer.  Refrigerate";
        if (dreamWhipInstruction2 && [dreamWhipInstruction2.instructionText isEqualToString:dreamWhipInstruction2OldText]){
            dreamWhipInstruction2.instructionText = dreamWhipInstruction2NewText;
        }
    }
    else {
        NSLog(@"Either recipe was deleted or already changed, don't need to update.");
    }
    
    //For Sweet and Source Pork:
    // -> Add notes (previously blank).
    RCPRecipe *sweetAndSourPorkRecipe = [RCPRecipe MR_findFirstByAttribute:@"recipeName" withValue:@"Sweet and Sour Pork"];
    if (sweetAndSourPorkRecipe){
        NSString *sweetAndSourPorkOldNotesText = @"Usually I brown the ribs and put them in a baking dish.  Make sauce of other ingredients and pour over ribs and bake about 3 hours at 325 degrees.";
        NSString *sweetAndSourPorkNewNotesText = @"I always marinade for hours before cooking. I do believe this is the key to having the ribs fall off the bone tender! I just use a large bottle of Kikkoman Teriyaki Marinade and Sauce, but I am sure other marines are fine.";
        if ([sweetAndSourPorkRecipe.recipeNotes isEqualToString:sweetAndSourPorkOldNotesText]){
            sweetAndSourPorkRecipe.recipeNotes = sweetAndSourPorkNewNotesText;
        }
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
