//
//  ViewController.m
//  DrawMailer
//
//  Created by -=fAlC0n=- on 11/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sharePicture {
    UIImage *image = [self.customView createImageFromContext];
    NSString *message = @"Here's a great drawing!";
    NSArray *postItems = @[message, image];
    NSLog(@"THis is the array items %@", postItems);
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES
                     completion:nil];
//    self.actVC = activityVC;
}

// Tell the CustomView to clear its screen
- (IBAction) cls {
    NSLog(@"Clear screen!");
    [self.customView cls];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"mySegue"])
//    {
//        SliderViewController *targetVC = (SliderViewController *)segue.destinationViewController;
//        
//        NSLog(@"This is inside the prepare for segue");
////        targetVC.received = self;
//    }
//}
-(IBAction)sliderValueChanged:(UISlider*)slider
{
    float r=[[NSString stringWithFormat:@"%.0f",_r.value] floatValue];
    float g=[[NSString stringWithFormat:@"%.0f",_g.value]floatValue];
    float b=[[NSString stringWithFormat:@"%.0f",_b.value]floatValue];
    
    UIColor *colorToSet=[UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1];
    
    NSLog(@"This is the color to set %@", colorToSet);
    
//    [_colorLabel setBackgroundColor:colorToSet];
    //    setBackground  = colorToSet;
    
    
    [self.customView bgColor:colorToSet];

}

-(IBAction)undoLayer {
    [self.customView undo];
    
}


- (IBAction)exit:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to quit ?" message:@"Your drawing will be deleted if not shared" delegate:self cancelButtonTitle:@"Not cool" otherButtonTitles:@"Cool",nil];
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"Cancel button is tapped");
    } else if (buttonIndex == alertView.firstOtherButtonIndex) {
        NSLog(@"OK button is pressed");
        exit(0);
    }
}
@end
