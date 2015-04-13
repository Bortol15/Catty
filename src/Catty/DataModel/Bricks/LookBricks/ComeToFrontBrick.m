/**
 *  Copyright (C) 2010-2015 The Catrobat Team
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

#import "ComeToFrontBrick.h"
#import "Script.h"

@implementation ComeToFrontBrick

- (BOOL)isSelectableForObject
{
    return (! [self.script.object isBackground]);
}

- (NSString*)brickTitle
{
    return kLocalizedComeToFront;
}

- (SKAction*)action
{
    return [SKAction runBlock:[self actionBlock]];
}

- (dispatch_block_t)actionBlock
{
    return ^{
        NSDebug(@"Performing: %@", self.description);
        CGFloat zValue = self.script.object.zPosition;
        CGFloat frontValue = [self.script.object.program numberOfNormalObjects];
        self.script.object.zPosition = frontValue;
        for(SpriteObject *obj in self.script.object.program.objectList){
            if((obj.zPosition > zValue) && (obj.zPosition <= frontValue) && (obj != self.script.object)) {
                obj.zPosition -=1;
            }
        }

        NSDebug(@"%f",self.script.object.zPosition );
    };
}

#pragma mark - Description
- (NSString*)description
{
    return [NSString stringWithFormat:@"ComeToFront"];
}

@end