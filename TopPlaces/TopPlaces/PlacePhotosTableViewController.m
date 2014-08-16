//
//  PlacePhotosTableViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/16/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import "TopPlaces.h"

@interface PlacePhotosTableViewController ()

@property (nonatomic, strong) TopPlaces *placePictures;
@property (nonatomic, strong) NSArray *photoURLs;

@end

@implementation PlacePhotosTableViewController

#pragma mark - Lazy Instantiation

- (TopPlaces *)placePictures
{
    if (!_placePictures)
        _placePictures = [[TopPlaces alloc] init];
    return _placePictures;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"%@", self.placeID);
    [self.placePictures queryForPhotos:self.placeID];
    NSLog(@"%@", [self.placePictures retrievePhotoURLs]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%i", [[self.placePictures retrievePhotoURLs] count]);
    return [[self.placePictures retrievePhotoURLs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
