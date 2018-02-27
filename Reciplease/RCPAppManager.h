//
//  RCPAppManager.h
//  Reciplease
//
//  Created by Daniel Yessayian on 8/21/17.
//  Copyright © 2017 Daniel Yessayian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RCPRecipeIngredientMeasurementType) {
    RCPRecipeIngredientMeasurementTypeCup = 0,
    RCPRecipeIngredientMeasurementTypeClove = 1,
    RCPRecipeIngredientMeasurementTypeDash = 2,
    RCPRecipeIngredientMeasurementTypeDrop = 3,
    RCPRecipeIngredientMeasurementTypeFluidOunce = 4,
    RCPRecipeIngredientMeasurementTypeGallon = 5,
    RCPRecipeIngredientMeasurementTypeGram = 6,
    RCPRecipeIngredientMeasurementTypeKilogram = 7,
    RCPRecipeIngredientMeasurementTypePound = 8,
    RCPRecipeIngredientMeasurementTypeLiter = 9,
    RCPRecipeIngredientMeasurementTypeMilligram = 10,
    RCPRecipeIngredientMeasurementTypeOunce = 11,
    RCPRecipeIngredientMeasurementTypePiece = 12,
    RCPRecipeIngredientMeasurementTypePinch = 13,
    RCPRecipeIngredientMeasurementTypePint = 14,
    RCPRecipeIngredientMeasurementTypeQuart = 15,
    RCPRecipeIngredientMeasurementTypeSheet = 16,
    RCPRecipeIngredientMeasurementTypeShot = 17,
    RCPRecipeIngredientMeasurementTypeTablespoon = 18,
    RCPRecipeIngredientMeasurementTypeTeaspoon = 19,
};


@interface RCPAppManager : NSObject

+ (instancetype)sharedInstance;
- (NSString*)stringWithEnum:(NSUInteger)enumVal;
- (NSUInteger)enumFromString:(NSString*)strVal default:(NSUInteger)def;
- (NSUInteger)enumFromString:(NSString*)strVal;



- (NSString*) retrievePathForFilenameWithString:(NSString*)filename;

@property (nonatomic, strong) NSMutableArray *appColorsArray;
@property (nonatomic, strong) NSMutableArray *measurementTypesArray;




@end
