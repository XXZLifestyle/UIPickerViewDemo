//
//  PickerView.h
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/2.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickerView;

@protocol PickerViewDelegate <NSObject>

/*!
 @method
 @abstract 滑动选择器后,获取该选择器上面的内容
 @discussion nil
 @param nil
 @param nil
 @result nil
 */
- (void)pickerViewContentWithRow:(NSInteger)row component:(NSInteger)component;

@end

@interface PickerView : UIView

@end
