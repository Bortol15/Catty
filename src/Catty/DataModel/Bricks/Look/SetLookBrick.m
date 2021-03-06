/**
 *  Copyright (C) 2010-2021 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "SetLookBrick.h"
#import "Script.h"
#import "CBMutableCopyContext.h"
#import "Pocket_Code-Swift.h"

@implementation SetLookBrick

- (BOOL)isDisabledForBackground
{
    return YES;
}

- (kBrickCategoryType)category
{
    return kLookBrick;
}

- (NSString*)pathForLook
{
    return [self.look pathForScene:self.script.object.scene];
}

#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"SetLookBrick (Look: %@)", self.look.name];
}

- (BOOL)isEqualToBrick:(Brick*)brick
{
    if([self.look isEqual:((SetLookBrick*)brick).look])
        return YES;
    return NO;
}

- (Look *)lookForLineNumber:(NSInteger)lineNumber andParameterNumber:(NSInteger)paramNumber
{
    return self.look;
}

- (void)setLook:(Look *)look forLineNumber:(NSInteger)lineNumber andParameterNumber:(NSInteger)paramNumber
{
    if(look)
        self.look = look;
}

#pragma mark - Default values
- (void)setDefaultValuesForObject:(SpriteObject*)spriteObject
{
    if(spriteObject) {
        NSArray *looks = spriteObject.lookList;
        if([looks count] > 0)
            self.look = [looks objectAtIndex:0];
        else
            self.look = nil;
    }
}

#pragma mark - Resources
- (NSInteger)getRequiredResources
{
    return kNoResources;
}

- (id)mutableCopyWithContext:(CBMutableCopyContext*)context
{
    if (! context) NSError(@"%@ must not be nil!", [CBMutableCopyContext class]);
    SetLookBrick *brick = [[self class] new];
    
    id updatedReference = [context updatedReferenceForReference: self.look];

    if (updatedReference != nil) {
        brick.look = updatedReference;
    } else {
        brick.look = self.look;
    }
    
    return brick;
}

@end
