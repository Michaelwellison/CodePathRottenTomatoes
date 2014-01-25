//
//  MovieDetailViewController.m
//  tomatoes
//
//  Created by Michael Ellison on 1/22/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *movieDetailImage;
@property (strong, nonatomic) IBOutlet UILabel *synopsisDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *castDetailLabel;


@end

@implementation MovieDetailViewController
@synthesize movieDetails;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@", movieDetails.title];

    [self.synopsisDetailLabel setText:movieDetails.synopsis];
    [self.castDetailLabel   setText:movieDetails.cast];
    [self.movieDetailImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", movieDetails.posters]]];
    
}

@end