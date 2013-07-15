//
//  FConnection.m
//  Copyright (c) 2013 Fury Mobile. All rights reserved.
//
//  License:
//
//  Apache License
//  Version 2.0, January 2004
//  http://www.apache.org/licenses/
//

#import <Foundation/Foundation.h>

@interface FConnection :  NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic) int responseCode;
@property (nonatomic,retain) NSURLResponse *response;

-(id)initWithRequest:(NSURLRequest *)request;
-(void)start:(void(^)(id obj, NSError * error))completionBlock;

@end
