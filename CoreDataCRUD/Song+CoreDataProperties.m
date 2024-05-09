//
//  Song+CoreDataProperties.m
//  CoreDataCRUD
//
//  Created by Juan Pablo Alvarez Loran on 26/04/24.
//
//

#import "Song+CoreDataProperties.h"

@implementation Song (CoreDataProperties)

+ (NSFetchRequest<Song *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Song"];
}

@dynamic title;
@dynamic rating;
@dynamic songId;

@end
