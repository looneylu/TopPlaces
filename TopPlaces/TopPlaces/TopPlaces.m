//
//  TopPlaces.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/14/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "TopPlaces.h"
#import "FlickrFetcher.h"

@implementation TopPlaces

#pragma mark - Lazy Instantiation


#pragma mark - Methods

- (NSArray *)getTopPlaces
{
    //retrieve data from Flickr for top places.
    // create NSData to contain information returned from Flickr
    NSData *data = [NSData dataWithContentsOfURL:[FlickrFetcher URLforTopPlaces]];
    
    //data returned is in JSON format
    // turn the JSON into property list
    NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // take places information from JSONData and add each place to topPlaces array
    NSDictionary *placeResults = JSONData[@"places"];
    NSArray *places = placeResults[@"place"];
    
    //get place names
    NSMutableArray *placeNames = [[NSMutableArray alloc] init];
    for (NSDictionary *place in places)
    {
        [placeNames addObject:[place objectForKey:@"_content" ]];
    }
    
    NSLog(@"%@", places);
    
    return placeNames;
}

- (void) queryForPhotos
{
    
}

- (NSArray *)placeNameSplitIntoComponents
{
    // get top places using above method
    NSArray *placeNames = [[NSArray alloc] initWithArray:[self getTopPlaces]];
    
    // placesWithNamesSplit
    self.placesWithNamesSplit = [[NSMutableArray alloc] init];
    
    // go through array of placeNames and split up names into components
    for (NSString *name in placeNames)
    {
        // split strings in plaeNames array into components
        NSArray *splitName = [name componentsSeparatedByString:@","];

        // dictionary will hold place names split up into city and country
        NSMutableDictionary *placeDictionary = [[NSMutableDictionary alloc] init];
            
        // each splitName array has 3 objects
        // first object will be city name
        // 2nd object will be district name
        // 3rd object is the country name
        [placeDictionary setObject:[splitName objectAtIndex:0] forKey:@"city"];
        [placeDictionary setObject:[splitName objectAtIndex:1] forKey:@"district"];
        [placeDictionary setObject:[splitName lastObject] forKey:@"country"];
        
        [self.placesWithNamesSplit addObject:placeDictionary];
    }
    
    // Sort array in alphabetical order by city and country
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"city" ascending:YES];
    [self.placesWithNamesSplit sortUsingDescriptors:@[sortDescriptor1, sortDescriptor2]];

    return self.placesWithNamesSplit;
}


- (NSArray *)numberOfCountries
{
    // returns an array of just the top countries
    int count = 0;
    NSMutableArray *countryArray = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i < [self.placesWithNamesSplit count] ; i++)
    {
        if (![[[self.placesWithNamesSplit objectAtIndex:i] objectForKey:@"country"] isEqualToString:[[self.placesWithNamesSplit objectAtIndex:i-1] objectForKey:@"country"]])
        {
            [countryArray addObject:[[self.placesWithNamesSplit objectAtIndex:i-1] objectForKey:@"country"]];
            count++;
        }
    }
    
    [countryArray addObject:[[self.placesWithNamesSplit lastObject] objectForKey:@"country"]];

    return countryArray;
}

- (NSArray *) topPlacesByCountryArray
{
    // two dimensional array to get top places divided by countries
    NSArray *topCountries = [[NSArray alloc] initWithArray:[self numberOfCountries]];
    
    NSMutableArray *outerArray = [[NSMutableArray alloc] init];
    
    for (NSString *string in topCountries)
    {
        NSMutableArray *innerArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in self.placesWithNamesSplit)
        {
            if ([[dict objectForKey:@"country"] isEqualToString:string])
            {
                [innerArray addObject:dict];
            }

        }
        
        [outerArray insertObject:innerArray atIndex:[outerArray count]];
    }
    return outerArray;
}


@end
