//
//  Nov7AppDelegate.m
//  Nov7
//
//  Created by Michael Gradilone on 11/7/13.
//  Copyright (c) 2013 FintechSolutions. All rights reserved.
//

#import "Nov7AppDelegate.h"

@implementation Nov7AppDelegate



- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
	// Override point for customization after application launch.
    // Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];
	NSLog(@"bundle.bundlePath == \"%@\"", bundle.bundlePath);
    
	NSString *filename = [bundle pathForResource: @"musette" ofType: @"mp3"];
	NSLog(@"filename == \"%@\"", filename);
    
	url = [NSURL fileURLWithPath: filename isDirectory: NO];
	NSLog(@"url == \"%@\"", url);
    
    player.volume = 1.0;		//the default full
	player.numberOfLoops = -1;	//negative for infinite loop
    
    
    //video file
    NSString *videoFileName = [bundle pathForResource: @"sneeze" ofType: @"m4v"];
	NSLog(@"video filename == \"%@\"", videoFileName);
    videoURL = [NSURL fileURLWithPath: videoFileName isDirectory: NO];
	NSLog(@"url == \"%@\"", videoURL);
    
    videoPlayer = [[MPMoviePlayerController alloc] init];
	if (videoPlayer == nil) {
		NSLog(@"could not create MPMoviePlayerController");
		return YES;
	}
    
    videoPlayer.shouldAutoplay = NO; //don't start spontaneously
	videoPlayer.scalingMode = MPMovieScalingModeAspectFill;
	videoPlayer.controlStyle = MPMovieControlStyleDefault ;
	videoPlayer.movieSourceType = MPMovieSourceTypeFile; //vs. stream
	[videoPlayer setContentURL: url];
    

    //NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
     [center addObserver: self selector: @selector(playbackDidFinish:) name: MPMoviePlayerPlaybackDidFinishNotification object: videoPlayer
     ];

    
	UIScreen *screen = [UIScreen mainScreen];
	view = [[View1 alloc] initWithFrame: screen.applicationFrame];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window addSubview: view];
	[self.window makeKeyAndVisible];

	return YES;
}

- (void) valueChanged: (id) sender {
    
    if ( [sender isKindOfClass:[UISegmentedControl class]]) {
        
        UISegmentedControl *control = sender;
        
        switch (control.selectedSegmentIndex) {
                
            case 0:	//Play Video
                
                //if player is playing, stop it.
                if (player.playing) {
                    [player stop];
                }
                
                //now start the vide0
                videoPlayer.view.frame = view.frame;
                [view removeFromSuperview];
                [self.window addSubview: videoPlayer.view];
                [videoPlayer play];
        
                
                break;
                
            case 1:	//Play Audio
                
                if (player == nil) {
                    //Create the audio player.
                    
                    NSError *error = nil;
                    player = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
                    if (player == nil) {
                        NSLog(@"AVAudioPayer initWithContentsOfURL:error: %@", error);
                        break;
                    }
                    

                    
                    player.delegate = self;
                    player.volume = 1.0;		//the default
                    player.numberOfLoops = 0;	//negative for infinite loop
                }
                
                
                if (player.playing) {
                    [player stop];
                    break;
                }
                
                if (![player prepareToPlay]) {
                    NSLog(@"AVAudioPlayer prepareToPlay failed.");
                    break;
                }
                
                if (![player play]) {
                    NSLog(@"AVAudioPlayer play failed.");
                    break;
                }
                
                
                
                break;
                
            case 2:	//Noting
                
                
            default:
                NSLog(@"UISegmentedControl selectedSegmentIndex == %ld",
                      (long)control.selectedSegmentIndex);
                break;
        }

        
    } else if ( [sender isKindOfClass:[UISlider class]]) {
        UISlider *s = sender;
        player.volume = s.value / 100;
    }
	
}

- (void) playbackDidFinish: (NSNotification *) notification {
	//notification.object is the movie player controller.
	[videoPlayer.view removeFromSuperview];
	[UIApplication sharedApplication].statusBarHidden = NO;
	[self.window addSubview: view];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
