//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/14/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "TopPlaces.h"
#import "PlacePhotosTableViewController.h"
#import "RecentTopPictures.h"

@interface TopPlacesViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - Properties

@property (strong, nonatomic) IBOutlet UITableView *topPlacesTableView;
@property (strong, nonatomic) NSArray *topPlaces;
@property (strong, nonatomic) NSArray *topCountries;
@property (strong, nonatomic) NSArray *topPlacesByCountryArray;
@property (strong, nonatomic) TopPlaces *places;
@property (strong, nonatomic) RecentTopPictures *recentPictures;

@end

@implementation TopPlacesViewController

#pragma mark - Lazy Instantiation

- (TopPlaces *)places
{
    if (!_places)
        _places = [[TopPlaces alloc] init];
    return _places;
}

- (RecentTopPictures *) recentPictures
{
    if (!_recentPictures)
        _recentPictures = [[RecentTopPictures alloc] init];
    
    return _recentPictures;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topPlacesTableView.delegate = self;
    self.topPlacesTableView.dataSource = self;
    
    self.topPlaces = [[NSArray alloc] initWithArray:[self.places placeNameSplitIntoComponents]];
    self.topCountries = [[NSArray alloc] initWithArray:[self.places numberOfCountries]];
    self.topPlacesByCountryArray = [[NSArray alloc] initWithArray:[self.places topPlacesByCountryArray]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.title = @"Top Places"; 
}

#pragma mark - Delegate/Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // to access city and country names, get to dictionary inside embedded array
    NSString *cityName = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"city"];
    NSString *districtName = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"district"];
    cell.textLabel.text = cityName;
    cell.detailTextLabel.text = districtName;

//    cell.textLabel.text = [NSString stringWithFormat:@"Section %i Row %i", indexPath.section, indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of rows section should have
    return [[self.topPlacesByCountryArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // the number of sections is equal to the number of top countries
    return  [self.topCountries count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //returns the country title for each section of table view
    return [self.topCountries objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the placeID before segueing to photos table view
    NSString *placeID = [[NSString alloc] init];
    placeID = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]objectForKey:@"place_id"];
    
    self.recentPictures = nil;
    self.recentPictures.cityName = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"city"];
    self.recentPictures.districtName = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"district"];
    self.recentPictures.countryName = [[[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"country"];
    self.recentPictures.placeID = [[NSString alloc] initWithString:placeID];

    self.recentPictures.pictureDict = [[self.topPlacesByCountryArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"toPhotos" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toPhotos"])
    {
        PlacePhotosTableViewController *PlacePhotosTVC = segue.destinationViewController;
        PlacePhotosTVC.selectedPlace = self.recentPictures;
    }
    
    
}


@end
