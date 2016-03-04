//
//  TQTableViewController.m
//  9.23听书
//
//  Created by 童裳强 on 15/9/23.
//  Copyright © 2015年 ellemoi_alami. All rights reserved.
//

#import "TQTableViewController.h"
#import "TQWordModle.h"
#import <AVFoundation/AVFoundation.h>


@interface TQTableViewController ()<AVAudioPlayerDelegate>

@property (nonatomic,strong) NSArray *word;

@property (nonatomic,strong)AVAudioPlayer *bgmusicpaluer;
@property (nonatomic,strong)AVAudioPlayer *wordspalyer;
@property (nonatomic,strong)CADisplayLink *link;




@end

@implementation TQTableViewController

-(CADisplayLink *)link{
    
    
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update1)];
    }
    return  _link;
}


-(NSArray *)word{
    if (_word==nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"一东.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            TQWordModle *modle = [TQWordModle WordModelWithdict:dic];
            [arrayM addObject:modle];
        }
        _word = arrayM;
    }
    return _word;
}

- (IBAction)CLick:(UIBarButtonItem *)sender {
    NSURL *bgURl = [[NSBundle mainBundle] URLForResource:@"Background.caf" withExtension:nil];
    NSURL *musicURl = [[NSBundle mainBundle] URLForResource:@"一东.mp3" withExtension:nil];
    
    
    self.bgmusicpaluer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgURl error:nil];
    self.wordspalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURl error:nil];
    self.wordspalyer.delegate = self;
    [self.wordspalyer prepareToPlay];
    [self.wordspalyer play];
    [self.bgmusicpaluer prepareToPlay];
    [self.bgmusicpaluer play];
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [self.wordspalyer stop];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}


-(void)update1{
    // NSLog(@"进来了吗");
    NSInteger count = self.wordspalyer.currentTime;
    NSInteger countM = self.word.count-1;
    
    
    for (NSInteger i=countM; i>=0; i--) {
        TQWordModle *model = self.word[i];
        if (count>(model.time-0.5)) {
            //NSLog(@"i=====%ld",i);
            [self selectcell:i];
            break;
        }
    }
}


-(void)selectcell:(NSInteger)idx{
    NSIndexPath *index = [NSIndexPath indexPathForItem:idx inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)viewDidLoad {
    //NSLog(@"word==%@",self.word);
    [super viewDidLoad];
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.word.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TQWordModle *model = self.word[indexPath.row];
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = model.text;
   // NSLog(@"%@",model.text);
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
