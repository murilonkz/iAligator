//
//  IndexViewController.m
//  Navegador
//
//  Created by Murilo Campaner on 18/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import "IndexViewController.h"
#import "BdController.h"
#import "FavoritosViewController.h"
#import "HistoricoViewController.h"
#import "WebViewController.h"
#import "ItemHistorico.h"
@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize menuLateral, content, txtField;
bool isShown = false;
static WebViewController * wvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BdController *bd = [[BdController alloc]init];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openMenu)];
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
    
    [rightGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [leftGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[self view] addGestureRecognizer:rightGesture];
    [[self view] addGestureRecognizer:leftGesture];

    wvc = [[WebViewController alloc]init];
    [content addSubview:[wvc view]];
    
}

- (IBAction)openNavegacao:(id)sender {
    [self removeAllContent];
    
    for (UIView *subview in content.subviews)
    {
        if (subview.tag == 1)
        {
            subview.hidden = NO;
        }
    }
    [self closeMenu];
}

- (IBAction)openMenuIcon:(id)sender {
    if(!isShown){
        [self openMenu];
    }else{
        [self closeMenu];
    }
    
}


- (IBAction)openFavoritos:(id)sender {
    [self removeAllContent];
    
    bool achou = NO;
    for (UIView *subview in content.subviews)
    {
        if (subview.tag == 2)
        {
            subview.hidden = NO;
            achou = YES;
        }
    }
    
    if (!achou) {
        FavoritosViewController *fvc = [[FavoritosViewController alloc]init];
        [content addSubview:[fvc view]];
    }
    [self closeMenu];
}

- (IBAction)openHistorico:(id)sender {
    [self removeAllContent];

    bool achou = NO;
    for (UIView *subview in content.subviews)
    {
        if (subview.tag == 3)
        {
            subview.hidden = NO;
            achou = YES;
        }
    }
    
    if (!achou) {
        HistoricoViewController *hvc = [[HistoricoViewController alloc]init];
        [content addSubview:[hvc view]];
    }
    [self closeMenu];
}

- (void) removeAllContent
{
    for (UIView *subview in content.subviews)
    {
        if ([subview isKindOfClass:[UIView class]] && subview.tag != 99)
        {
            subview.hidden = YES;
        }
    }
}

- (void)openMenu
{
    if (!isShown) {
        menuLateral.frame =  CGRectMake(0, 43, 0, 525);
        menuLateral.hidden = NO;

        [UIView animateWithDuration:0.25 animations:^{
            menuLateral.frame =  CGRectMake(0, 43, 230, 525);
        }];
        isShown = YES;
    }
}

- (void)closeMenu
{
    if (isShown) {
        [UIView animateWithDuration:0.25 animations:^{
            menuLateral.frame =  CGRectMake(0, 43, 0, 525);
        }];
        isShown = NO;
    }
}

/* Funcoes de Navegação */
- (IBAction)goBack:(id)sender
{
    [wvc goBack:sender];
}

- (IBAction)goForward:(id)sender
{
    [wvc goForward:sender];
}

- (IBAction)goUrl:(id)sender
{
    NSString *url = txtField.text;
    [wvc goUrl:url];
    [txtField resignFirstResponder];
    [self openNavegacao:sender];
    
    /* Insere no histórico */
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    ItemHistorico *item = [[ItemHistorico alloc]init];
    
    [item setUrl: txtField.text];
    [item setDate: dateString];
    
    BdController *bd = [[BdController alloc]init];
    [bd insertIntoHistoric:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
