//
//  Movie.m
//  tomatoes
//
//  Created by Michael Ellison on 1/20/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.cast = [[dictionary[@"abridged_cast"] valueForKey:@"name"] componentsJoinedByString:@""];
    }
    
    return self;
}

@end

