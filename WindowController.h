// -*- mode:objc -*-
//
//  WindowController.h
//  HunspellDictKoUpdater
//
//  Created by Hayoung Jeong on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WindowController : NSWindowController {
  IBOutlet NSTextField *title;
  IBOutlet NSTextField *tVersion;
  IBOutlet NSTextField *tInstalledVersion;
  IBOutlet NSTextField *tInstalledDate;
  IBOutlet NSTextField *vVersion;
  IBOutlet NSTextField *vInstalledVersion;
  IBOutlet NSTextField *vInstalledDate;
}

- (IBAction)install:(id)sender;
- (IBAction)openHomepage:(id)sender;

@end
