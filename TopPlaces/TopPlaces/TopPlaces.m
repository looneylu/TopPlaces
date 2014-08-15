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
    
    return placeNames;
}

- (NSArray *)placeNameSplitIntoComponents
{
    // get top places using above method
    NSArray *placeNames = [[NSArray alloc] initWithArray:[self getTopPlaces]];
    
    // placesWithNamesSplit
    NSMutableArray *placesWithNamesSplit = [[NSMutableArray alloc] init];
    
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
        
        [placesWithNamesSplit addObject:placeDictionary];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [placesWithNamesSplit sortedArrayUsingDescriptors:sortDescriptors];
    placesWithNamesSplit = [NSMutableArray arrayWithArray:sortedArray];
    NSLog(@"%@", placesWithNamesSplit); 
    
    return placesWithNamesSplit;
}

- (void) test
{
    NSLog(@"test"); 
}
@end
