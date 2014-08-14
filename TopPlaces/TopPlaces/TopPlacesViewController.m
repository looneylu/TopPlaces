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
    
}

#pragma mark - Delegate/Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.topPlaces objectAtIndex:indexPath.row] objectForKey:@"city"] ;
    cell.detailTextLabel.text = [[self.topPlaces objectAtIndex:indexPath.row] objectForKey:@"country"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.topPlaces count];
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
