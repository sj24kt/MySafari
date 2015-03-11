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
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

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

// while the webView is loading show the spinner
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

// when the webView finishes loading hide the spinner
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

# pragma mark - IBActions

// clicking the < in the bottom webView returns to previous url
- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}

// clicking the > in the bottom webView goes forward to previous viewed url
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}

// clicking the Reload button in the webView reloads the current url
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}






// clicking the Stop button in webView stops loading immediately
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}







# pragma mark - Helper methods

- (void)goToURLString:(NSString *)string {
    NSString *urlString = string;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


@end
