//
//  FirstViewController.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "LocateStrongholdController.h"
#import "StrongholdUtility.h"

@interface LocateStrongholdController ()

@end

@implementation LocateStrongholdController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)locate:(id)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *x1Number = [f numberFromString:self.x1.text];
    NSNumber *z1Number = [f numberFromString:self.z1.text];
    NSNumber *f1Number = [f numberFromString:self.f1.text];
    
    NSNumber *x2Number = [f numberFromString:self.x2.text];
    NSNumber *z2Number = [f numberFromString:self.z2.text];
    NSNumber *f2Number = [f numberFromString:self.f2.text];
    
    SVector *result;
    
    result = [StrongholdUtility locateStrongholdWithVector1:[[SVector alloc] initWithX:x1Number Z:z1Number F:f1Number] Vector2:[[SVector alloc] initWithX:x2Number Z:z2Number F:f2Number]];
    
    self.x.text = result.x.stringValue;
    self.z.text = result.z.stringValue;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.x1 resignFirstResponder];
    [self.z1 resignFirstResponder];
    [self.f1 resignFirstResponder];
    
    [self.x2 resignFirstResponder];
    [self.z2 resignFirstResponder];
    [self.f2 resignFirstResponder];
    
    [self.x resignFirstResponder];
    [self.z resignFirstResponder];
    
    return YES;
}
@end
