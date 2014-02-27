//
//  GraphDisplayerViewController.m
//  ver
//
//  Created by mrpacpac on 27/02/14.
//
//

#import "GraphDisplayerViewController.h"

@implementation GraphDisplayerViewController

NSArray *tableData;
NSString *file;

- (void) viewDidLoad
{
    [super viewDidLoad];

    // by default, load nothing
    file = nil;

    // as no file is selected (yet), disable the open button
    self.navigationItem.rightBarButtonItem.enabled = false;

    // load the graph samples files list
    NSError* error;
    NSString* graphSamplesPath = [[NSBundle mainBundle] resourcePath];
    graphSamplesPath = [graphSamplesPath stringByAppendingPathComponent:@"samples"];
    tableData = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:graphSamplesPath error:&error];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) openAlgo:(id) sender
{
    NSLog(@"Load %@", file);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    file = [tableData objectAtIndex:indexPath.row];

    self.navigationItem.rightBarButtonItem.enabled = true;
}

@end
