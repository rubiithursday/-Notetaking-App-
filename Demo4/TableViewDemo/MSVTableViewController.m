//
//  MSVTableViewController.m
//  TableViewDemo
//
//  Created by Michael Vitrano on 4/8/14.
//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import "MSVTableViewController.h"
#import "MSVInputViewController.h"
#import "MSVStringDetailViewController.h"

@interface MSVTableViewController () <UITableViewDataSource, UITableViewDelegate, MSVInputViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *strings;

@end

@implementation MSVTableViewController

- (instancetype)init
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.strings = [NSMutableArray array];
    }
    return self;
}

#pragma mark - View Controller LifeCycle

- (void)loadView
{
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"RubiiNote 4000";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    MSVInputViewController *inputVC = [[MSVInputViewController alloc] init];
    inputVC.delegate = self;
    
    [self presentViewController:inputVC animated:YES completion:nil];
}

#pragma mark - MSVInputViewControllerDelegate Methods

- (void)inputController:(MSVInputViewController *)controller didFinishWithText:(NSString *)text
{
    [self.strings addObject:text];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifer"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseIdentifer"];
    }

    cell.textLabel.text = self.strings[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSVStringDetailViewController *detailVC = [[MSVStringDetailViewController alloc] initWithRow:indexPath.row
                                                                                          string:self.strings[indexPath.row]];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
