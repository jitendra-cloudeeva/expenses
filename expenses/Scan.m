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
@synthesize imagePickerController, imageView, image;

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
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *itemright = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
    self.navigationItem.rightBarButtonItem = itemright;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 290)];
    imageView.image = [UIImage imageNamed:@"NoImage.png"];
    [self.view addSubview:imageView];
    
    UIButton *choosePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choosePhotoBtn setFrame:CGRectMake(10, 433, 135, 37)];
    choosePhotoBtn.tag = 1;
    [choosePhotoBtn setImage:[UIImage imageNamed:@"ChoosePhoto.png"] forState:UIControlStateNormal];
    [choosePhotoBtn addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choosePhotoBtn];
    
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.tag = 2;
    [takePhotoBtn setFrame:CGRectMake(115, 433, 240, 37)];
    [takePhotoBtn setImage:[UIImage imageNamed:@"takephoto.png"] forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
    
    if(image)
    {
        imageView.image = image;
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

-(void) getPhoto:(id) sender
{
    UIButton *btn = (UIButton *) sender;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    if(btn.tag == 1)
    {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
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
    if (alertView.tag == 1 || alertView.tag == 2)
    {
        //[self.navigationController popViewControllerAnimated:TRUE];
    }
}

@end
