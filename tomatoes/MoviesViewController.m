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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView
     dequeueReusableCellWithIdentifier:@"MovieCell"];
    
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
    // The code below a submits a request to the URL and the URL returns JSON is returned in the form of "data"
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        self.movies = [object objectForKey:@"movies"];
        
        [self.tableView reloadData];
        
        NSLog(@"movies: %@", self.movies);
        
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

@end
