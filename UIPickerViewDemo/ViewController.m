//
//  ViewController.m
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/2.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "ViewController.h"
#import "PickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PickerView *pickerView = [[PickerView alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-10*2, 400)];
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
