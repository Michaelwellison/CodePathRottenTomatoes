//
//  MovieCell.m
//  tomatoes
//
//  Created by Michael Ellison on 1/20/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import "MovieCell.h"

@interface  MovieCell ()



@end


@implementation MovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
