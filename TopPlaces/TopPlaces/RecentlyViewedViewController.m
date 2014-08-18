//
//  RecentlyViewedViewController.m
//  TopPlaces
//
//  Created by Luis Carbuccia on 8/14/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "RecentlyViewedViewController.h"
#import "PictureViewController.h"
#import "RecentTopPictures.h"

@interface RecentlyViewedViewController () <UITableViewDelegate,UITableViewDataSource>

#pragma mark - Properties
@property (strong, nonatomic) IBOutlet UITableView *recentPhotosTableView;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) RecentTopPictures *selection;
@property (strong, nonatomic) NSURL *url;

@end

@implementation RecentlyViewedViewController

#pragma mark - Lazy Instantiation

- (NSArray *) test
{
    if (!_photos)
        _photos = [[NSArray alloc] init];
    return _photos;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recentPhotosTableView.dataSource = self;
    self.recentPhotosTableView.delegate = self;
    
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedPictures"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.title = @"Recently Viewed"; 
    
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedPictures"];
    [self.recentPhotosTableView reloadData]; 
}

#pragma mark - UITableView DataSource/Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *cellTitle = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"photoTitle"];
    NSString *country = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"countryName"];
    cell.textLabel.text = cellTitle;
    cell.detailTextLabel.text = country;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selection = [[RecentTopPictures alloc] init];
    self.selection.cityName = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"cityName"];
    self.selection.photoURL = [NSURL URLWithString:[[self.photos objectAtIndex:indexPath.row] objectForKey:@"photourl"]];
    self.selection.districtName = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"districtName"];
    self.selection.countryName = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"countryName"];
    self.selection.photoTitle = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"photoTitle"];

    [self performSegueWithIdentifier:@"recentlyViewed" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"recentlyViewed"])
    {
        PictureViewController *pictureViewVC = segue.destinationViewController;

        pictureViewVC.selectedPhoto = self.selection;
        pictureViewVC.url = self.selection.photoURL;
    }
}


@end
