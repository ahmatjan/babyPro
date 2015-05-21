//
//  ViewController.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "ViewController.h"
#import "BACoreData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BACoreData coreData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
