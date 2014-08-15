//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/14/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "TopPlaces.h"

@interface TopPlacesViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - Properties

@property (strong, nonatomic) IBOutlet UITableView *topPlacesTableView;
@property (strong, nonatomic) NSArray *topPlaces;
@property (strong, nonatomic) NSArray *topCountries;
@property (strong, nonatomic) NSArray *topPlacesByCountryArray;
@property (strong, nonatomic) TopPlaces *places;

@end

@implementation TopPlacesViewController

#pragma mark - Lazy Instantiation

- (TopPlaces *)places
{
    if (!_places)
        _places = [[TopPlaces alloc] init];
    return _places;
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

    NSLog(@"%@", [[self.topPlacesByCountryArray objectAtIndex:1] objectAtIndex:2]); 
    NSLog(@"%i",[self.topCountries count]);
}

#pragma mark - Delegate/Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
//    cell.textLabel.text = [[self.topPlaces objectAtIndex:indexPath.row] objectForKey:@"city"] ;
//    cell.detailTextLabel.text = [[self.topPlaces objectAtIndex:indexPath.row] objectForKey:@"country"];
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:0] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:1] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:1] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 2)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:2] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:2] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 3)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:3] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:3] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 4)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:4] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:4] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 5)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:5] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:5] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 6)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:6] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:6] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 7)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:7] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:7] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 8)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:8] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:8] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 9)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:9] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:9] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 10)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:10] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:10] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 11)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:11] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:11] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }    else if (indexPath.section == 12)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:12] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:12] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 13)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:13] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:13] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    else if (indexPath.section == 14)
    {
        cell.textLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:14] objectAtIndex:indexPath.row] objectForKey:@"city"];
        cell.detailTextLabel.text = [[[self.topPlacesByCountryArray objectAtIndex:14] objectAtIndex: indexPath.row] objectForKey:@"country"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int count = [self.topPlacesByCountryArray count];

    if (section == 0)
        return [[self.topPlacesByCountryArray objectAtIndex:0] count];
    else if (section == 1)
        return [[self.topPlacesByCountryArray objectAtIndex:1] count];
    else if (section == 2)
        return [[self.topPlacesByCountryArray objectAtIndex:2] count];
    else if (section == 3)
        return [[self.topPlacesByCountryArray objectAtIndex:3] count];
    else if (section == 4)
        return [[self.topPlacesByCountryArray objectAtIndex:4] count];
    else if (section == 5)
        return [[self.topPlacesByCountryArray objectAtIndex:5] count];
    else if (section == 6)
        return [[self.topPlacesByCountryArray objectAtIndex:6] count];
    else if (section == 7)
        return [[self.topPlacesByCountryArray objectAtIndex:7] count];
    else if (section == 8)
        return [[self.topPlacesByCountryArray objectAtIndex:8] count];
    else if (section == 9)
        return [[self.topPlacesByCountryArray objectAtIndex:9] count];
    else if (section == 10)
        return [[self.topPlacesByCountryArray objectAtIndex:10] count];
    else if (section == 11)
        return [[self.topPlacesByCountryArray objectAtIndex:11] count];
    else if (section == 12)
        return [[self.topPlacesByCountryArray objectAtIndex:12] count];
    else if (section == 13)
        return [[self.topPlacesByCountryArray objectAtIndex:13] count];
    else
        return [[self.topPlacesByCountryArray objectAtIndex:14] count];

//    return [self.topPlaces count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 1;
    return [self.topCountries count];
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
