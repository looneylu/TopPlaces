//
//  PlacePhotosTableViewController.h
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/16/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentTopPictures.h"

@interface PlacePhotosTableViewController : UITableViewController

@property (nonatomic, strong) RecentTopPictures *selectedPlace;

@end
