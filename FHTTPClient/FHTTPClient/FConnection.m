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

#import "FConnection.h"

@interface FConnection ()

@property (nonatomic,retain) NSURLConnection * connection;
@property (nonatomic,retain) NSURLRequest *request;
@property (nonatomic,retain) NSMutableData *data;
@property (nonatomic,copy) void (^completionBlock) (id obj, NSError* error);

@end

static NSMutableArray *sharedConnections;

@implementation FConnection

-(id)initWithRequest:(NSURLRequest *)request {
	self = [super init];
    if (self) {
        [self setRequest:request];
		if(!sharedConnections)
			sharedConnections = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)start:(void(^)(id obj, NSError * err))completionBlock {
	self.data = [[NSMutableData alloc]init];
	self.completionBlock = completionBlock;
    self.connection = [[NSURLConnection alloc]initWithRequest:[self request] delegate:self startImmediately:YES];
    [sharedConnections addObject:self];
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.response = response;
    self.data = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(self.completionBlock)
        self.completionBlock(self.data,nil);
    [sharedConnections removeObject:self];
	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if(self.completionBlock)
        self.completionBlock(nil,error);
    [sharedConnections removeObject:self];
	
}

@end
