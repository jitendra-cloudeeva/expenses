//
//  Scan.m
//  expenses
//
//  Created by jrajoria on 3/31/14.
//  Copyright (c) 2014 cloudeeva. All rights reserved.
//

#import "Scan.h"
#import "AppDelegate.h"

@implementation Scan
@synthesize imagePickerController, imageView, image, imageButtonIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    hasImage = FALSE;
    
    self.view.backgroundColor = [UIColor colorWithRed:165/255.0f green:217/255.0f blue:235/255.0f alpha:1.0f];
    
    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
    self.navigationItem.rightBarButtonItem = itemright;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 290)];
    imageView.image = [UIImage imageNamed:@"NoImage.png"];
    [self.view addSubview:imageView];
    
    CGRect frame, remain;
    CGRectDivide(self.view.bounds, &frame, &remain, 44, CGRectMaxYEdge);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    
    
    [toolbar sizeToFit];
    toolbar.tintColor = [UIColor whiteColor];
    toolbar.barTintColor = [UIColor colorWithRed:50/255.0f green:134/255.0f blue:221/255.0f alpha:1.0f];//[UIColor colorWithRed:47/255.0f green:177/255.0f blue:241/255.0f alpha:1.0f];
    
    [self.view addSubview:toolbar];
    
    if(image)
    {
        imageView.image = image;
        UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(RemoveImage)];
        self.navigationItem.rightBarButtonItem = itemright;
    }
    else
    {
        UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
        self.navigationItem.rightBarButtonItem = itemright;
        
        toolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithTitle:@"Choose Picture" style:UIBarButtonItemStyleDone target:self action:@selector(getPhotoFromAlbum)],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Take Picture" style:UIBarButtonItemStyleDone target:self action:@selector(getPhotoFromCamera)],
                         nil];
    }
}

- (IBAction)uploadImage
{
    if(!hasImage)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please take photo of receipt." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [APP_DELEGATE.arrayReceiptImages addObject:imageView.image];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RemoveImage
{
    if(image)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to delete this image?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        alert.tag = 2;
        [alert show];
        return;
    }
}

-(void) getPhotoFromAlbum
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void) getPhotoFromCamera
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] || [[device model] isEqualToString:@"iPad"])
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
    }
}

- (void) viewWillAppear:(BOOL)animated;
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	self.navigationItem.title = @"Scan Receipt";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    imagePickerController.view.hidden = YES;
    
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.view bringSubviewToFront:imageView];
    hasImage = TRUE;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    // Dismiss the image selection and close the program
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if(buttonIndex == 0)
        {
            [APP_DELEGATE.arrayReceiptImages removeObjectAtIndex:imageButtonIndex];
            [self.navigationController popViewControllerAnimated:TRUE];
        }
    }
}

@end
