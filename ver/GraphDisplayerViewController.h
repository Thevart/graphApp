//
//  GraphDisplayerViewController.h
//  ver
//
//  Created by mrpacpac on 26/02/14.
//
//

#import <UIKit/UIKit.h>

@interface GraphDisplayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblGDName;

@property (weak, nonatomic) IBOutlet UITableView *TVAlgoNames;

- (IBAction)btnOpen:(id)sender;

@end
