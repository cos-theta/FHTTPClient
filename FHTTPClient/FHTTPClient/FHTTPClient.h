//
//  FHTTPClient.h
//  Copyright (c) 2013 Fury Mobile. All rights reserved.
//
//  License:
//
//  Apache License
//  Version 2.0, January 2004
//  http://www.apache.org/licenses/
//

#import <Foundation/Foundation.h>

typedef enum {
    GET      	= 0,
    POST     	= 1,
    PUT   		= 2,
    DELETE      = 3,
} FHTTPVerbs;

@class FResponse;

typedef void(^FSuccessBlock)		(FResponse* response);
typedef void(^FFailureBlock)		(FResponse* response, NSError* error);

@interface FHTTPClient : NSObject

@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *accept;
@property (nonatomic, copy) NSString *token;
@property (nonatomic) double timeout;
@property (nonatomic) BOOL useCompression;

#pragma mark - Initialization

-(id)initWithBaseUrl:(NSURL *)baseUrl;

#pragma mark - HTTP Methods

-(void) get:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure;

-(void) post:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure;

-(void) put:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure;

-(void) delete:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure;

@end
