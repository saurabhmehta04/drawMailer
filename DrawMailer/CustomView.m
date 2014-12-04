//
//  CustomView.m
//  DrawMailer
//
//  Created by -=fAlC0n=- on 11/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame - will I ever get called??");
        
    }
    
    return self;
}


- (UIImage *)createImageFromContext{
    NSLog(@"createImageFromContext - dump view contents to image");
    
    CGRect contextRect  = CGRectMake(0, 0, self.bounds.size.width, 	self.bounds.size.height);
    
    UIGraphicsBeginImageContext(contextRect.size);
    
    // get whatever the user drew in the view
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // create a new image with it
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    

    
    return theImage;
}


- (void)cls{
    NSLog(@"cls - clear the screen");
    // our next layer starts at zero again
    self.layerIndex = 0;
    // loop through array and get rid of all the points in each 	// array
    for (NSMutableArray *points in self.layers) {
        [points removeAllObjects];
    }
    
    // get rid of all of the empty layer arrays
    [self.layers removeAllObjects];
    
    // update view
    [self setNeedsDisplay];
}


-(void) bgColor:(UIColor *)bgColor {
    self.bgColor = bgColor;
    [self setNeedsDisplay];
    
}

-(void)undo {
    

    if (self.layerIndex == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello There..." message:@"There is nothing more to undo !" delegate:self cancelButtonTitle:@"Not cool" otherButtonTitles:@"Cool",nil];
        
        [alert show];
        // get rid of all of the empty layer arrays
        [self.layers removeAllObjects];
    }
    else {
        self.layerIndex = self.layerIndex-1;
        
        for (NSMutableArray *points in self.layers) {
            [points removeLastObject];
        }
        
        [self.layers removeLastObject];
        
    }
    
    [self setNeedsDisplay];

}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"drawRect - I get called when the view is 'dirty'");
    // Get pointer to view
   	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    UIRectFill([self bounds]);

    
    // Loop through our layers (if any)
    for (NSMutableArray *points in self.layers) {
        // The "pen" color is white - change this if you want
        [[UIColor redColor] set];   // changing the stroke color
        
        
        // set the line width to 3
        CGContextSetLineWidth(context, 3.0f);
        // loop through each layers point values
        for (int i = 0; i < [points count] - 1; i++){
            CGPoint pt1 = [[points objectAtIndex:i] 			CGPointValue];
            CGPoint pt2 = [[points objectAtIndex:(i+1)] 			CGPointValue];
            CGContextMoveToPoint(context, pt1.x, pt1.y);
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            CGContextStrokePath(context);
        }
    }
    
    
    
//    [[UIColor redColor]set]; //set the background color to gray
    

}

-(NSMutableArray *)layers{
    if(_layers == nil) {
        _layers = [[NSMutableArray alloc] init];
        
    }
    else{
        NSLog(@"The number of layers are %lu", (unsigned long)_layers.count);
    }

    return _layers;
}

// On new touch, start a new array (layer) of points
- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event{
    
    NSMutableArray *points = [NSMutableArray array];
    [self.layers addObject:points];
    
    CGPoint pt = [[touches anyObject]locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:pt]];
    NSLog(@"Layer %d created and total number of layers are %lu", self.layerIndex, (unsigned long)self.layers.count);
    
}

// Add each point to the correct array as the finger moves
- (void)touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event{
    NSMutableArray *points = [self.layers objectAtIndex: 	self.layerIndex];
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:pt]];
    
    [self setNeedsDisplay];
    //NSLog(@"point added");
}

- (void)touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event{
    NSMutableArray *points = [self.layers objectAtIndex:self.layerIndex];
    NSLog(@"layer %d now has %lu points", self.layerIndex, (unsigned long)[points 	count]);
    self.layerIndex ++;
    
    [self setNeedsDisplay];
}


@end
