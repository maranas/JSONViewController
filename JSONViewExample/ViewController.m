//
//  ViewController.m
//  JSONViewExample
//
//  Created by moises on 7/26/18.
//  Copyright © 2018 pie33.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:pathToFile];
    
    NSError *error = nil;
    NSDictionary *parsedJSON =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:0
                                          error:&error];
    
    [self updateWithJSONDictionary:parsedJSON];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
