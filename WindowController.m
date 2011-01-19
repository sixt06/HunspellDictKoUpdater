//
//  WindowController.m
//  HunspellDictKoUpdater
//
//  Created by Hayoung Jeong on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WindowController.h"


@implementation WindowController

#define LocalizedString(string) NSLocalizedString(string, string)

- (void)awakeFromNib {
  [title setStringValue:LocalizedString(@"Hunspell Korean Dictionary Updater")];
  [tVersion setStringValue:LocalizedString(@"Version")];
  [tInstalledVersion setStringValue:LocalizedString(@"Installed Version")];
  [tInstalledDate setStringValue:LocalizedString(@"Installed Date")];

  [vVersion setStringValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *installedVersion = [defaults objectForKey:@"installedVersion"];
  NSDate *installedDate = [defaults objectForKey:@"installedDate"];

  if ([installedVersion length])
    [vInstalledVersion setStringValue:installedVersion];

  if (installedDate) {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [vInstalledDate setStringValue:[dateFormatter stringFromDate:installedDate]];
  }
}

- (IBAction)install:(id)sender {
  NSFileManager *fm = [NSFileManager defaultManager];
  NSString *installPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Spelling"];
  NSString *dicPath = [installPath stringByAppendingPathComponent:@"ko.dic"];
  NSString *affPath = [installPath stringByAppendingPathComponent:@"ko.aff"];

  NSError *error = nil;

  if ([fm fileExistsAtPath:dicPath]) {
    NSLog(@"ko.dic exists, remove old ko.dic");
    if (![fm removeItemAtPath:dicPath error:&error]) {
      [NSAlert alertWithError:error];
      return;
    }
  } 

  if (![fm copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"ko.dic" ofType:nil]
		   toPath:dicPath
		    error:&error]) {
    [NSAlert alertWithError:error];
    return;
  }

  if ([fm fileExistsAtPath:affPath]) {
    NSLog(@"ko.aff exists, remove old ko.aff");
    if (![fm removeItemAtPath:affPath error:&error]) {
      [NSAlert alertWithError:error];
      return;
    }
  } 
  
  if (![fm copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"ko.aff" ofType:nil]
		   toPath:affPath
		    error:&error]) {
    [NSAlert alertWithError:error];
    return;
  }

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSDate date] forKey:@"installedDate"];
  [defaults setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
	       forKey:@"installedVersion"];

  [[NSAlert alertWithMessageText:LocalizedString(@"Install is successed.")
		   defaultButton:nil
		 alternateButton:nil
		     otherButton:nil
       informativeTextWithFormat:@""] runModal];
}

- (IBAction)openHomepage:(id)sender {
  NSLog(@"openHomepage");
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://code.google.com/p/spellcheck-ko/"]];
}

@end
