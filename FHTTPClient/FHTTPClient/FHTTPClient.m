//
//  FHTTPClient.m
//  Copyright (c) 2013 Fury Mobile. All rights reserved.
//
//  License:
//
//  Apache License
//  Version 2.0, January 2004
//  http://www.apache.org/licenses/
//

#import "FHTTPClient.h"
#import "FConnection.h"
#import "FResponse.h"

@interface FHTTPClient ()

@property (nonatomic, retain) FConnection *connection;
@property (nonatomic, retain) NSURL *baseUrl;

@end

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation FHTTPClient

#pragma mark - Initialization

-(id)initWithBaseUrl:(NSURL *)baseUrl {
	if (self = [super init]) {
		_baseUrl = baseUrl;
		[self baseInit];
	}
	return self;
}

-(void)baseInit {
	_timeout = 30;
	_useCompression = YES;
    _headers = [NSMutableDictionary dictionaryWithDictionary:@{@"Content-Type" : @"application/json", @"Accept" : @"application/json", @"Cache-Control" : @"no-cache", @"Pragma" : @"no-cache", @"Connection" : @"close" }];
}

#pragma mark - HTTP Methods

-(void) get:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure {
	[self send:method withVerb:GET withParameters:parameters success:success failure:failure];
}

-(void) post:(NSString*)method
withParameters:(NSDictionary*)parameters
	 success:(FSuccessBlock)success
	 failure:(FFailureBlock)failure {
	[self send:method withVerb:POST withParameters:parameters success:success failure:failure];
}

-(void) put:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FSuccessBlock)success
	failure:(FFailureBlock)failure {
	[self send:method withVerb:PUT withParameters:parameters success:success failure:failure];
}

-(void) delete:(NSString*)method
withParameters:(NSDictionary*)parameters
	   success:(FSuccessBlock)success
	   failure:(FFailureBlock)failure {
	[self send:method withVerb:DELETE withParameters:parameters success:success failure:failure];
}

#pragma mark - Internal

-(void)send:(NSString*)method withVerb:(FHTTPVerbs)verb withParameters:(NSDictionary*)parameters success:(FSuccessBlock)success
	failure:(FFailureBlock)failure {
	
	NSData* body;
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _baseUrl, method]];
	NSString* verbString;
	switch (verb) {
		case GET:
			verbString = @"GET";
			break;
		case POST:
			verbString = @"POST";
			break;
		case PUT:
			verbString = @"PUT";
			break;
		case DELETE:
			verbString = @"DELETE";
			break;
		default:
			break;
	}
	if (parameters) {
		switch (verb) {
			case POST:
			case PUT: {
				NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
																   options:NSJSONWritingPrettyPrinted
																	 error:nil];
				
				body = jsonData;
				break;
			}
			default: {
				NSString *urlWithParams = [[url absoluteString] stringByAppendingFormat:@"?%@", [self urlEncodedStringFromDictionary:parameters]];
				url = [NSURL URLWithString:urlWithParams];
				break;
			}
		}
	}
	
	NSMutableDictionary *requestHeaders = [NSMutableDictionary dictionaryWithDictionary:_headers];
	
	if (_token)
		[requestHeaders setObject:[NSString stringWithFormat:@"Bearer %@", _token] forKey:@"Authorization"];
	
	if (_userAgent)
		[requestHeaders setObject:_userAgent forKey:@"User-Agent"];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLCacheStorageNotAllowed
													   timeoutInterval:_timeout];
	[request setHTTPMethod:verbString];
    [request setAllHTTPHeaderFields:requestHeaders];
	if (_useCompression)
		[request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    if (parameters)
        [request setHTTPBody:body];
	
	_connection = [[FConnection alloc]initWithRequest:request];
	[_connection start:^(id obj, NSError *error) {;
		if (error && failure){
			failure([[FResponse alloc]initWithStatus:_connection.responseCode andResponse:[self deserializeResponse:obj]], error);
		} else if (!error && success) {
			success([[FResponse alloc]initWithStatus:_connection.responseCode andResponse:[self deserializeResponse:obj]]);
		}
	}];
}

-(id)deserializeResponse:(id)obj
{
    if (!obj)
		return nil;
    NSError *jsonError = nil;
	id response = [NSJSONSerialization JSONObjectWithData:obj options:kNilOptions error:&jsonError];
	return response;
}

-(NSString*) urlEncodedStringFromDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [NSMutableArray array];
	[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(obj)];
        [parts addObject: part];
	}];
    return [parts componentsJoinedByString: @"&"];
}

@end
