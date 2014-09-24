//
//  ImageStore.h
//  Sports
//
//  Created by winitmb7 on 31/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageStore : NSObject {
    
}

/** 
 * Returns Directory path for Appplications Documents
 * @return path
 */
+ (NSString *) GetDocumentDirectoryPath;


/** 
 * Returns Existing path for Appplications Documents
 * @return Bool
 */

+ (BOOL) isImageExistsWithNameInDirctory:(NSString *)strImgName;

/** 
 * Returns Image 
 * @return UIimage
 */

+ (UIImage *) returnImageWithName:(NSString *)strImgName;

/** 
 * Returns saveImageWithData 
 * @return UIimage
 */

+ (void) saveImageWithData:(NSData *)imageData withImageName:(NSString *)imageName;

@end
