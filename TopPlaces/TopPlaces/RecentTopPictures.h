//
//  RecentTopPictures.h
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/17/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentTopPictures : NSObject

@property (nonatomic, strong) NSString *placeID;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) NSURL *photoURL; 

@end