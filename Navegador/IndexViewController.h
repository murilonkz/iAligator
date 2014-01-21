//
//  IndexViewController.h
//  Navegador
//
//  Created by Murilo Campaner on 18/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *menuLateral;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIView *content;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)goUrl:(id)sender;
- (IBAction)openFavoritos:(id)sender;
- (IBAction)openHistorico:(id)sender;
- (IBAction)openNavegacao:(id)sender;
- (void) removeAllContent;
@end
