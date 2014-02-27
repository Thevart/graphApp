//
//  GraphDisplayerViewController.h
//  ver
//
//  Created by mrpacpac on 27/02/14.
//
//

#import <UIKit/UIKit.h>

@interface GraphDisplayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *graphDisplayerName;
@property (weak, nonatomic) IBOutlet UITableView *algoTableView;
- (IBAction)openAlgo:(id)sender;
@end
