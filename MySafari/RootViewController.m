//
//  ViewController.m
//  MySafari
//
//  Created by Sherrie Jones on 3/11/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) UINavigationItem *navTitle;

@property (assign,nonatomic) CGFloat textFieldPosition;
@property NSURL *url;

@end

@implementation RootViewController

# pragma mark - ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    self.urlTextField.hidden = NO;

    [self goToURLString:@"http://www.mobilemakers.co"];

    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
}

# pragma mark - UITextField

// enters new urls in text field
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToURLString:textField.text];

    // dismiss keyboard
    [self.urlTextField resignFirstResponder];
    return YES;
}

// clears the entire textField on clicking in box
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.urlTextField clearsOnBeginEditing];
    self.urlTextField.placeholder = @"enter a url";
}

# pragma mark - UIWebView

// while the webView is loading show the spinner
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

// when the webView finishes loading hide the spinner
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];

    // set textField to show current url
    NSString *currentURL = webView.request.URL.absoluteString;
    self.urlTextField.text = currentURL;

    if ([self.webView canGoBack]) {
        [self.backButton setEnabled:YES];
    } else{
        [self.backButton setEnabled:NO];
    }

    if ([self.webView canGoForward]) {
        [self.forwardButton setEnabled:YES];
    } else{
        [self.forwardButton setEnabled:NO];
    }

    //set the address bar using a JavaScript function passed to the webView as a string
    //self.urlTextField.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //self.navTitle.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    NSString* title = [self.webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    self.urlTextField.text = title;

//    self.navTitle.title = title;
//    NSLog(@"Title: %@", self.navTitle.title);

}

# pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"%f TEXTFIELDPOSITION", self.textFieldPosition);
//    NSLog(@"%f CURRENTLOCATION", self.webView.scrollView.contentOffset.y);

    if (self.textFieldPosition < self.webView.scrollView.contentOffset.y) {
        self.urlTextField.hidden = YES;
    } else if(self.textFieldPosition > self.webView.scrollView.contentOffset.y){
        self.urlTextField.hidden = NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.textFieldPosition = self.webView.scrollView.contentOffset.y;
//    NSLog(@"%f WHAT AM I", self.textFieldPosition);
}

# pragma mark - IBActions

// clicking the < in the bottom webView returns to previous url if it can
- (IBAction)onBackButtonPressed:(UIButton *)sender {

    // check if we can go back
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        [self.backButton setEnabled:YES];
    } else {
        [self.backButton setEnabled:NO];
    }
}

// clicking the > in the bottom webView goes forward to previous viewed url if it can
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    // check if we can go forward
    if ([self.webView canGoForward]) {
        [self.webView goForward];
        [self.forwardButton setEnabled:YES];
    } else {
        [self.forwardButton setEnabled:NO];
    }
}

// clicking the Reload button in the webView reloads the current url
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
    self.urlTextField.hidden = NO;
}

// clicking the Stop button in webView stops loading immediately
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
    [self.spinner stopAnimating];
}

// show informational message in popup on info button
- (IBAction)comingSoonButton:(UIButton *)sender {
    UIAlertView *comingSoon = [[UIAlertView alloc] initWithTitle:@"Coming Soon!" message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [comingSoon show];
}


# pragma mark - Helper methods

- (void)goToURLString:(NSString *)string {
    NSString *urlString = string;

    if ([urlString hasPrefix:@"http://"]) {
        self.url = [NSURL URLWithString:urlString];
    } else {
        self.url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}



@end
