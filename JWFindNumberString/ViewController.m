//
//  ViewController.m
//  JWFindNumberString
//
//  Created by JessieWu on 2018/7/23.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self FindNumber:@"we have finded more 20000. but he have 100000. suo you shuzi shi 112.46 huozhe 1239870."];
}

#pragma mark - methods
- (NSArray *)FindNumber:(NSString *)string {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    NSString *zhz = @"\\d+?(.\\d+)+";
    
    NSError *error;
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:zhz options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult*> *arr = [regx matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *result in arr) {
        NSLog(@"result is: %@", [string substringWithRange:result.range]);
        NSString *numString = [string substringWithRange:result.range];
        if (numString) {
            [array addObject:numString];
        }
    }
    NSLog(@"find all number is: %@", array);
    return array;
}

@end
