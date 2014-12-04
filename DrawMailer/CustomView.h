//
//  CustomView.h
//  DrawMailer
//
//  Created by -=fAlC0n=- on 11/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (nonatomic, strong)NSMutableArray *layers;
@property (nonatomic, assign)int layerIndex;
@property (nonatomic, strong) UIColor *bgColor;

-(UIImage *) createImageFromContext;
-(void)cls;

-(void)bgColor:(UIColor *)bgColor;
-(void)undo;


@end


