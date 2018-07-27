//
//  JSONViewController.m
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "JSONViewController.h"
#import "JSONView.h"
@import YogaKit;

@interface JSONViewController ()
@property (nonatomic) NSDictionary *viewDictionary;
@property (nonatomic, readonly) dispatch_queue_t parseQueue;
@property (nonatomic) JSONView *containedView;
@property (nonatomic) UIScrollView *scrollContainer;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation JSONViewController
@synthesize parseQueue = _parseQueue;

- (instancetype) init {
    if ((self = [super init])) {
        _parseQueue = dispatch_queue_create("com.json.parsequeue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (dispatch_queue_t) parseQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_parseQueue = dispatch_queue_create("com.json.parsequeue", DISPATCH_QUEUE_SERIAL);
    });
    return _parseQueue;
}

- (instancetype) initWithJSONData:(NSData*)jsonData {
    if ((self = [super init])) {
        [self updateWithJSONData:jsonData];
    }
    return self;
}

- (void) updateWithJSONData:(NSData*)jsonData {
    [self.activityIndicatorView stopAnimating];
    __weak typeof (self) weakSelf = self;
    dispatch_async(self.parseQueue, ^{
        typeof (self) strongSelf = weakSelf;
        NSError *error = nil;
        NSDictionary *parsedJSON =
            [NSJSONSerialization JSONObjectWithData:jsonData
                                            options:0
                                              error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.containedView removeFromSuperview];
            strongSelf.containedView = [[JSONView alloc] initWithDictionary:parsedJSON];
            if (strongSelf.isViewLoaded) {
                [strongSelf updateView];
            }
        });
    });
}

- (void) updateView {
    if (!self.containedView.superview) {
        [self.scrollContainer addSubview:self.containedView];
    }
    self.title = self.containedView.title;
    [self.scrollContainer configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.height = YGPointValue(self.view.bounds.size.height);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignStretch;
        layout.justifyContent = YGJustifyFlexStart;
    }];
    [self.scrollContainer.yoga applyLayoutPreservingOrigin:YES];
    CGSize contentSize = CGSizeMake(self.containedView.bounds.size.width,
                                    self.containedView.bounds.size.height + self.containedView.frame.origin.y);
    self.scrollContainer.contentSize = contentSize;
    [self.activityIndicatorView stopAnimating];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollContainer = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollContainer];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    NSDictionary *views = @{@"scroll" : self.scrollContainer};
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scroll]|"
                                             options:0
                                             metrics:nil
                                               views:views]
    ];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scroll]|"
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
