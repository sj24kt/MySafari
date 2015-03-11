//
//  ViewController.m
//  MySafari
//
//  Created by Sherrie Jones on 3/11/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;

}









@end
