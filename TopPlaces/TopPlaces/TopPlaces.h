//
//  TopPlaces.h
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/14/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopPlaces : NSObject

@property (nonatomic, strong) NSMutableArray *placesWithNamesSplit;
@property (nonatomic) int numberOfDistinctCountriesInArray;

- (NSArray *)placeNameSplitIntoComponents;
- (NSArray *)getTopPlaces;
- (NSArray *) numberOfCountries;
- (NSArray *) topPlacesByCountryArray;

@end
