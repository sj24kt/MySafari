//
//  ViewController.m
//  MySafari
//
//  Created by Sherrie Jones on 3/11/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self goToURLString:@"http://www.mobilemakers.co"];
    self.webView.delegate = self;
}

// enters new urls in text field
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToURLString:textField.text];
    return YES;
}

# pragma mark - Helper methods

- (void)goToURLString:(NSString *)string {
    NSString *urlString = string;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


@end
