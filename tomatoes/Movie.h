//
//  Movie.h
//  tomatoes
//
//  Created by Michael Ellison on 1/20/14.
//  Copyright (c) 2014 Michael Ellison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) UIImage *poster;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end 
