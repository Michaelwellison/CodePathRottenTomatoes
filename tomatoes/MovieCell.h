//
//  MovieCell.h
//  tomatoes
//
//  Created by Michael Ellison on 1/20/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;
@property (nonatomic, weak) IBOutlet UIImage *posterImage;

@end
