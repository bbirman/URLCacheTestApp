//
//  ViewController.m
//  URLCacheTestApp
//
//  Created by Brianna Birman on 6/24/19.
//  Copyright © 2019 Salesforce.com, Inc. All rights reserved.
//

#import "ViewController.h"
@import SalesforceSDKCore;

@interface ViewController ()

@property(nonatomic, nonnull) SFSDKEncryptedURLCache *encryptedCache;
@property(nonatomic, nonnull) NSURL *url;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _encryptedCache = [[SFSDKEncryptedURLCache alloc] init];
        //_url = [[NSURL alloc] initWithString:@"https://webcache.googleusercontent.com/search?q=cache:drlf2DnmSH8J:https://www.salesforce.com/+&cd=1&hl=en&ct=clnk&gl=us"];
        //_url = [[NSURL alloc] initWithString:@"https://developer.apple.com/documentation/uikit/uiviewcontroller/1621359-initwithnibname?language=objc"];//
        _url = [[NSURL alloc] initWithString:@"https://c1.sfdcstatic.com/content/dam/web/en_us/www/images/home/recommended-for-you-moar.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"BB path %@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
    
    UIButton *noCacheButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 100, 300, 40)];
    [noCacheButton addTarget:self action:@selector(noCacheButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [noCacheButton setTitle:@"No cache load" forState:UIControlStateNormal];
    noCacheButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:noCacheButton];
    
    UIButton *cacheButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 200, 300, 40)];
    [cacheButton addTarget:self action:@selector(cacheButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [cacheButton setTitle:@"Cache load" forState:UIControlStateNormal];
    cacheButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:cacheButton];
    
    UIButton *removeSingleResponseButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 300, 300, 40)];
    [removeSingleResponseButton addTarget:self action:@selector(removeSingleResponseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [removeSingleResponseButton setTitle:@"Remove last response" forState:UIControlStateNormal];
    removeSingleResponseButton.backgroundColor = [UIColor orangeColor];
    //[self.view addSubview:removeSingleResponseButton];
    
    UIButton *removeAllResponsesButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 300, 300, 40)];
    [removeAllResponsesButton addTarget:self action:@selector(removeAllResponsesButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [removeAllResponsesButton setTitle:@"Remove all responses" forState:UIControlStateNormal];
    removeAllResponsesButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:removeAllResponsesButton];
}

- (void)cacheButtonTapped {
    NSLog(@"Cache button tapped");
    
    NSURLSessionConfiguration *cacheSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    cacheSessionConfig.requestCachePolicy = NSURLRequestReturnCacheDataDontLoad;
    cacheSessionConfig.URLCache = self.encryptedCache;
    NSURLSession *cacheSession = [NSURLSession sessionWithConfiguration:cacheSessionConfig];
    __block NSData *cacheData;
    __block NSURLResponse *cacheResponse;
    
    NSURLSessionDataTask *cacheLoad =
    [cacheSession dataTaskWithURL:self.url
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    cacheData = data;
                    cacheResponse = response;

                }];
    
//    NSURLSessionDownloadTask *download = [cacheSession downloadTaskWithURL:self.url];
//    [download resume];
    
    [cacheLoad resume];
}

- (void)noCacheButtonTapped {
    NSLog(@"No cache button tapped");
    
    NSURLSessionConfiguration *noCacheSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    noCacheSessionConfig.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    noCacheSessionConfig.URLCache = self.encryptedCache;
     NSURLSession *noCacheSession = [NSURLSession sessionWithConfiguration:noCacheSessionConfig];
    __block NSData *noCacheData;
    __block NSURLResponse *noCacheResponse;
    
    NSURLSessionDataTask *noCacheLoad =
    [noCacheSession dataTaskWithURL:self.url
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                      noCacheData = data;
                      noCacheResponse = response;
                  }];
    
//    NSURLSessionDownloadTask *download = [noCacheSession downloadTaskWithURL:self.url];
//    [download resume];
//
   [noCacheLoad resume];
}

- (void)removeSingleResponseButtonTapped {
    //todo
    //[[NSURLSession sharedSession].configuration.URLCache removeCachedResponseForRequest:<#(nonnull NSURLRequest *)#>];
}

- (void)removeAllResponsesButtonTapped {
    [[NSURLSession sharedSession].configuration.URLCache removeAllCachedResponses];
}

@end
