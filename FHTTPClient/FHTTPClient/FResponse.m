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

#import "FResponse.h"

@implementation FResponse

- (id) initWithStatus:(NSInteger)status
          andResponse:(id)response
{
    if (self = [super init])
    {
        _status = status;
        _response = response;
    }
    return self;
}

@end
