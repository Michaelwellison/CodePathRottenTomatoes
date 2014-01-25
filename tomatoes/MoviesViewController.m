//
//  MoviesViewController.m
//  tomatoes
//
//  Created by Michael Ellison on 1/15/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"

@interface MoviesViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, assign) BOOL hasError;
@property (nonatomic, strong) NSMutableArray *movies;

- (void)reload;

@end
@implementation MoviesViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Movies";
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    
    [refresh addTarget:self action:@selector(reload)
     
      forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    self.hasError = NO;
    
    [self reload];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSections {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.hasError) {
        return @"Network Error";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
        
        NSDictionary *movies = self.movies[indexPath.row];
        Movie *movie = [[Movie alloc] initWithDictionary:movies];
    
        cell.movieTitleLabel.text = movie.title;
        cell.synopsisLabel.text = movie.synopsis;
        cell.castLabel.text = movie.cast;
        [cell.posterImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", movie.posters]]];
        
        return cell;

}

#pragma mark - Private methods

- (void)reload {
    
    [self.spinner startAnimating];
    self.hasError = NO;
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            self.hasError = YES;
            self.movies = [[NSMutableArray alloc] init];
        } else {
            self.hasError = NO;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = [object objectForKey:@"movies"];
    
            NSLog(@"movies: %@", self.movies);
        }

        [self.spinner stopAnimating];
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
        [self.tableView reloadData];
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"this works");
    
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    NSDictionary *movies = self.movies[indexPath.row];
    Movie *movie = [[Movie alloc] initWithDictionary:movies];
    
    MovieDetailViewController *movieDetailViewController = (MovieDetailViewController *)segue.destinationViewController;
    [movieDetailViewController setMovieDetails:movie];
}

- (void)stopRefresh {

    [self.refreshControl endRefreshing];
}

@end
