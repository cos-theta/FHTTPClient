FHTTPClient
===========

An extremely simple iOS HTTP Client for REST services.

##Why another REST client?
After working with other Objective-C libraries to access RESTful services we realized that there was a ton of overkill.  Too many options and too many dependancies.  We took a stab at cutting down the overhead and creating a simple client to provide *simple* GET, POST, PUT, and DELETE functionality.

##Requirements
Although we've tested this code on iOS 5 and above, it's really meant for iOS 6+. 

##Installation
[CocoaPods](http://cocoapods.org) is the recommended way to add FHTTPClient to your project.

1. Add a pod entry for FHTTPClient to your Podfile `pod 'FHTTPClient', '~> 0.0.1'`
2. Install the pod(s) by running `pod install`.
3. Include FHTTPClient wherever you need it with `#import "FHTTPClient"`.

### ARC
FHTTPClient uses ARC.

If you are using FHTTPClient in your non-arc project, you will need to set a `-fobjc-arc` compiler flag on all of the source files. 

To set a compiler flag in Xcode, go to your active target and select the "Build Phases" tab. Now select all FHTTPClient source files, press Enter, insert `-fobjc-arc` and then "Done" to enable ARC for FHTTPClient.

##Usage
We love rocking your blocks off.  If you don't have a good understanding of using blocks you may want to check out Apple's [Blocks Programming Topics](http://developer.apple.com/library/ios/#documentation/cocoa/Conceptual/Blocks/Articles/00_Introduction.html) before using this codebase.

Using FHTTPClient is fairly straightforward.  Once you include your import (`#import "FHTTPClient.h"`) in your code, you can use the library as follows:

###GET

```objective-c
FHTTPClient* client = [[FHTTPClient alloc] initWithBaseUrl:baseUrl];
[client get:path withParameters:_parameters success:^(FResponse *response) {
		//Process your response
	} 
	failure:^(FResponse *response, NSError *error) {
		//Process your failure
	}
];

```
####Where:

1. baseUrl is an`NSURL` with the protocol, address or domain, and port.
2. path is the route you wish to invoke.
3. parameters is a name/value collection of parameters to pass either via a query string in a `GET` or `DELETE` call or inside the body of the message in the case of a `POST` or a `PUT`.

####Options and Notes:

1. Use `[client setToken:{TOKEN}]` to set the Authorization header with a Bearer token.
2. The library turns on GZIP compression by default.  To turn off compfression set the useCompression BOOL to `NO`.
3. Change your Content Type by calling `[client setContentType:{TYPE}]`. (Default value is `"application/json"`)
4. Change your Accept Type by calling [client setAccept:{TYPE}]. (Default value is `"application/json"`)
5. Adjust your timeout by calling [client setTimeout:{DOUBLE}].  (Default value is `30`)

##Contributions
Contributions to this repository are welcomed with open arms.  Pull requests are reviewed constantly.  Please feel free to fork and customize or improve as you see fit!

##Who in God's Name is Fury Mobile?
Fury Mobile is a mobile consulting organization based in Golden, CO.  We  not only focus on developing awesome mobile applications both for the iOS platform and for OS X but put an empahsis on mobile security and it's application on iOS devices.

Follow us on Twitter [@furymobile](https://twitter.com/furymobile)

## License

FHTTPClient is available under the Apache License Version 2.0 license. See the [LICENSE](LICENSE) file for more info.