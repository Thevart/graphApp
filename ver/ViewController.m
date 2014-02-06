//
//  ViewController.m
//  ver
//
//  Created by Michel Martin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@implementation ViewController
@synthesize leVer;
@synthesize leMessage;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIImage *img = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"cercle" ofType:@"png"]];
    CGRect cropRect = CGRectMake(0, 0, 30, 30);
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], cropRect);
    UIImageView *Ver = [[UIImageView alloc] initWithFrame:CGRectMake(150, 10, 30, 30)];
    Ver.image = [UIImage imageWithCGImage:imageRef];
    [self.view addSubview:Ver];
    CGImageRelease(imageRef);
    aTouche = 1; 
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];

    posX = location.x;
    posY = location.y;    Ver.alpha = 1.0f;
    Ver.center = CGPointMake(posX, posY);
    [vertexes addObject: Ver];
    leMessage.text = [NSString stringWithFormat: @"%i ...", vertexes.count];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    largeur = self.view.bounds.size.width;  // Largeur de l'écran
    hauteur = self.view.bounds.size.height; // Hauteur de l'écran
    vertexes = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [self setLeVer:nil];
    [self setLeMessage:nil];
    [self setLeVer:nil];
    [super viewDidUnload];

    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
