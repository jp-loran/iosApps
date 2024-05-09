//
//  Song+CoreDataProperties.h
//  CoreDataCRUD
//
//  Created by Juan Pablo Alvarez Loran on 26/04/24.
//
//

#import "Song+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Song (CoreDataProperties)

+ (NSFetchRequest<Song *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int16_t rating;
@property (nullable, nonatomic, copy) NSUUID *songId;

@end

NS_ASSUME_NONNULL_END
