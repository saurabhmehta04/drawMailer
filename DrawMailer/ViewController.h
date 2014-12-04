//
//  ViewController.h
//  DrawMailer
//
//  Created by -=fAlC0n=- on 11/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet CustomView *customView;
@property (nonatomic, strong) IBOutlet UIActivityViewController *actVC;
- (IBAction)sharePicture;
- (IBAction)cls;

@property (weak, nonatomic) IBOutlet UISlider *r;
@property (weak, nonatomic) IBOutlet UISlider *g;
@property (weak, nonatomic) IBOutlet UISlider *b;
//@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIButton *undo;
@property (weak, nonatomic) IBOutlet UIButton *exit;

-(IBAction)sliderValueChanged:(UISlider *)slider;
-(IBAction)undoLayer;
//-(IBAction)<#selector#>:(id)sender
//@property (weak, nonatomic) IBOutlet UIButton *setBackground;
- (IBAction)exit:(UIButton *)sender;

@end
