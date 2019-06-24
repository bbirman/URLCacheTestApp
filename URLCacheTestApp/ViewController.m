//
//  ViewController.m
//  URLCacheTestApp
//
//  Created by Brianna Birman on 6/24/19.
//  Copyright © 2019 Salesforce.com, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *cacheButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 100, 200, 40)];
    [cacheButton addTarget:self action:@selector(cacheButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [cacheButton setTitle:@"Cache load" forState:UIControlStateNormal];
    cacheButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:cacheButton];
    
    UIButton *noCacheButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 200, 200, 40)];
    [noCacheButton addTarget:self action:@selector(noCacheButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [noCacheButton setTitle:@"No cache load" forState:UIControlStateNormal];
    noCacheButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:noCacheButton];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)cacheButtonTapped {
    NSLog(@"Cache button tapped");
}

- (void)noCacheButtonTapped {
    NSLog(@"No cache button tapped");
}


@end
