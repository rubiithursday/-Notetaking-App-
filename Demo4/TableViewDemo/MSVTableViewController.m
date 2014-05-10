//
//  MSVTableViewController.m
//  TableViewDemo
//
//  Created by Rubii Pham.
//  Copyright (c) 2014 Pham. All rights reserved.


#import "MSVTableViewController.h"
#import "MSVInputViewController.h"
#import "MSVStringDetailViewController.h"

@interface MSVTableViewController () <UITableViewDataSource, UITableViewDelegate, MSVInputViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *strings;

@property (nonatomic, strong) NSMutableArray *rubiiNotes;

@end

@implementation MSVTableViewController

- (instancetype)init
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.strings = [NSMutableArray array];
		self.rubiiNotes = [NSMutableArray array];
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
    
    self.title = @"NoteTkr";
    
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

- (void)inputController:(MSVInputViewController *)controller didFinishWithRubiiNote:(NHPNote *)note {
	NSLog(@"%@", note.title);
	[self.rubiiNotes addObject:note];
	[self.tableView reloadData];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.strings.count;
	return self.rubiiNotes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifer"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseIdentifer"];
    }

//    cell.textLabel.text = self.strings[indexPath.row];
	
	NHPNote *tmpNote = self.rubiiNotes[indexPath.row];
	
	cell.textLabel.text = tmpNote.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//NHPNote *tmpNote = self.rubiiNotes[indexPath.row];
//    MSVStringDetailViewController *detailVC = [[MSVStringDetailViewController alloc] initWithRow:indexPath.row
  //                                                                                        string:tmpNote.title];
    
	MSVStringDetailViewController *detailVC = [[MSVStringDetailViewController alloc] initWithRow:indexPath.row noteObj:self.rubiiNotes[indexPath.row]];
	
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
