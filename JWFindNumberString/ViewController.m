//
//  ViewController.m
//  JWFindNumberString
//
//  Created by JessieWu on 2018/7/23.
//  Copyright © 2018年 JessieWu. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self FindNumber:@"we have finded more 20000. but he have 100000. suo you shuzi shi 112.46 huozhe 1239870."];
}

#pragma mark - UI
- (void)setupShowLabel:(NSAttributedString *)string {
    [self.showLabel setAttributedText:string];
}

- (void)showAlertView:(NSAttributedString *)string {
    NSString *message = [NSString stringWithFormat:@"%@", string];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alert addAction:commitAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - methods
- (NSArray *)FindNumber:(NSString *)string {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    NSString *zhz = @"\\d+?(.\\d+)+";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhz];
    BOOL isValid = [predicate evaluateWithObject:string];
    if (isValid) {
        NSLog(@"the string is valid.");
    }
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 8.0f;
    [aString addAttributes:@{NSParagraphStyleAttributeName: style} range:NSMakeRange(0, aString.length)];
    
    NSError *error;
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:zhz options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult*> *arr = [regx matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *result in arr) {
        NSLog(@"result is: %@", [string substringWithRange:result.range]);
        NSString *numString = [string substringWithRange:result.range];
        NSAttributedString *aNumString = [[NSAttributedString alloc] initWithString:numString attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        [aString replaceCharactersInRange:result.range withAttributedString:aNumString];
        if (numString) {
            [array addObject:numString];
        }
    }
    
    [self setupShowLabel:aString];
    NSLog(@"find all number is: %@", array);
    return array;
}

@end
