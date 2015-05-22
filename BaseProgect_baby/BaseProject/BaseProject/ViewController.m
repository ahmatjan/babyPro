//
//  ViewController.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "ViewController.h"
#import "BACoreData.h"
#import "BABAccount.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * file = [[NSBundle mainBundle] pathForResource:@"accountResponse" ofType:@"json"];
//    NSString * string = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:file] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
    BABAccount * account = [MTLJSONAdapter modelOfClass:[BABAccount class] fromJSONDictionary:[[dic objectForKey:@"result"] objectForKey:@"account"] error:nil];
    [account save];
    
    
    [BABAccount deleteforPredicate:nil];
    BABAccount * account1 = [[BABAccount alloc] init];
    account1.accessToken = @"1";
    account1.state = 3;
    [account1 save];
  NSArray *results =  [BABAccount searchforPredicate:nil];
    NSLog(@"%@",results);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
