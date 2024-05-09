//
//  AppDelegate.h
//  CoreDataCRUD
//
//  Created by Juan Pablo Alvarez Loran on 26/04/24.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

