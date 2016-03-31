//
//  PickerView.m
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/2.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "PickerView.h"
#import "ShowDateModel.h"

@interface PickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation PickerView {
    NSMutableArray *_minuteArr;
    NSMutableArray *_hourArr;
    NSMutableArray *_dayArr;
    
    BOOL _animated;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self buildLayout];
    }
    return self;
}

#pragma mark - 布局
- (void)buildLayout {
    _minuteArr = [NSMutableArray array];
    _hourArr = [NSMutableArray array];
    _dayArr = [NSMutableArray array];
    
    _animated = YES;
    
    //加载数据源
     _hourArr = [[ShowDateModel showCurrentDate] firstObject];
    _minuteArr = [[ShowDateModel showCurrentDate] objectAtIndex:1];
    _dayArr = [[ShowDateModel showCurrentDate] lastObject];
    
    [self addSubview:self.pickerView];
}

#pragma mark - getter
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-60);//有默认的高度
        _pickerView.backgroundColor = [UIColor magentaColor];
        _pickerView.delegate = self;
        _pickerView.dataSource  =self;
    }
    return _pickerView;
}

#pragma mark - UIPickerViewDataSource
//一共多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _dayArr.count;
    }else if (component == 1) {
        return _hourArr.count;
    }else if (component == 2) {
        return _minuteArr.count;
    }

    return 0;
}

#pragma mark - UIPickerViewDelegate
//每列每行对应显示的数据是什么,如果自定义了,该方法无效
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return @"XXZ";
//}

//某列每行文本属性的更改
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return nil;
//}

//自定义每列每行显示的view
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *showContent = [[UILabel alloc] init];
    showContent.backgroundColor = [UIColor cyanColor];
    showContent.textAlignment = NSTextAlignmentCenter;
    showContent.frame = CGRectMake(0, 0, 60, 40);
    
    if (component == 0) {
        showContent.frame = CGRectMake(0, 0, 160, 40);
        showContent.text = [_dayArr objectAtIndex:row];
    }else if (component == 1) {
        showContent.text = [_hourArr objectAtIndex:row];
    }else if (component == 2) {
        showContent.text = [_minuteArr objectAtIndex:row];
    }else{}
    
    return showContent;
}

//每列的width
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 160;
    }
    return 60;
}

//每列row的height
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

// 当选中了pickerView的某一行的时候调用
// 会将选中的列号和行号作为参数传入
// 只有通过手指选中某一行的时候才会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    XXZLog(@"动了.....");
    
    if (component == 0) {//用手滚动第0列,天列
        if (row == 0) {
            //移除原有的数据
            [_hourArr removeAllObjects];
            [_minuteArr removeAllObjects];
            
            //回到当天,进行判断符合条件的时间
            _hourArr = [[ShowDateModel showCurrentDate] firstObject];
            _minuteArr = [[ShowDateModel showCurrentDate] objectAtIndex:1];
            
            //刷新
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            
//            //第二,第三列回到第一行
//            [pickerView selectRow:0 inComponent:1 animated:_animated];
//            [pickerView selectRow:0 inComponent:2 animated:_animated];
        }else {
            //移除原有的数据
            [_hourArr removeAllObjects];
            [_minuteArr removeAllObjects];
            
            //重新赋值
            _minuteArr = [ShowDateModel setMinuteOrHourWithParameter:0 type:0];
            _hourArr = [ShowDateModel setMinuteOrHourWithParameter:8 type:1];
            
            //刷新
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            
//            //第二,第三列回到第一行
//            [pickerView selectRow:0 inComponent:1 animated:_animated];
//            [pickerView selectRow:0 inComponent:2 animated:_animated];
        }
        
    }else if (component ==1) {//用手滚动第1列,小时列
        if (row == 0) {//切换到第0行
            [_minuteArr removeAllObjects];//移除原有的数据
            
            //第0列是否在第0行
            NSInteger firstCmpn = [pickerView selectedRowInComponent:0];
            if (firstCmpn == 0) {//正常时间
//                [ShowDateModel showCurrentDate];//回到当天,进行判断符合条件的时间
                _minuteArr = [[ShowDateModel showCurrentDate] objectAtIndex:1];
            }else {//初始化
                _minuteArr = [ShowDateModel setMinuteOrHourWithParameter:0 type:0];
            }
            
            [pickerView reloadComponent:2];//刷新
//            [pickerView selectRow:0 inComponent:2 animated:_animated];//第二,第三列回到第一行
            
        }else {//切换到其他行
            [_minuteArr removeAllObjects];//移除原有的数据
            _minuteArr = [ShowDateModel setMinuteOrHourWithParameter:0 type:0];//重新赋值
            [pickerView reloadComponent:2];//刷新
//            [pickerView selectRow:0 inComponent:2 animated:_animated];//第二,第三列回到第一行
        }
    }else if (component == 2) {//用手滚动第2列,分钟列
        //此时,天数与小时,不用改变
    }else {}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
