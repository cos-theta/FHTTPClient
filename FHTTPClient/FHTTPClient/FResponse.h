//
//  FResponse.m
//  Copyright (c) 2013 Fury Mobile. All rights reserved.
//
//  License:
//
//  Apache License
//  Version 2.0, January 2004
//  http://www.apache.org/licenses/
//

@interface FResponse : NSObject

@property (nonatomic) NSInteger status;
@property (nonatomic) id response;

- (id) initWithStatus:(NSInteger)status
          andResponse:(id)response;

@end
