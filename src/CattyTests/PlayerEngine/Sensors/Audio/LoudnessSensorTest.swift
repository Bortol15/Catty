/**
 *  Copyright (C) 2010-2018 The Catrobat Team
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

import XCTest

@testable import Pocket_Code

final class LoudnessSensorTest: XCTestCase {
    
    var audioManager: AudioManagerMock!
    var sensor: LoudnessSensor!
    
    override func setUp() {
        audioManager = AudioManagerMock()
        sensor = LoudnessSensor { [weak self] in self?.audioManager }
    }
    
    override func tearDown() {
        sensor = nil
        audioManager = nil
    }
    
    func testDefaultRawValue() {
        let sensor = LoudnessSensor { nil }
        XCTAssertEqual(type(of: sensor).defaultRawValue, sensor.rawValue(), accuracy: 0.0001)
    }
    
    func testRawValue() {
        audioManager.mockedLoudnessInDecibels = 3
        XCTAssertEqual(3, sensor.rawValue(), accuracy: 0.0001)
        
        audioManager.mockedLoudnessInDecibels = -50
        XCTAssertEqual(-50, sensor.rawValue(), accuracy: 0.0001)
        
        audioManager.mockedLoudnessInDecibels = 10.786
        XCTAssertEqual(10.786, sensor.rawValue(), accuracy: 0.0001)
    }
    
    func testConvertToStandardized() {
        // background noise
        XCTAssertEqual(1, sensor.convertToStandardized(rawValue: -40), accuracy: 0.0001)
        
        // whisper
        XCTAssertEqual(6.3095, sensor.convertToStandardized(rawValue: -24), accuracy: 0.0001)
        
        // normal voice
        XCTAssertEqual(17.7827, sensor.convertToStandardized(rawValue: -15), accuracy: 0.0001)
        
        // shouting
        XCTAssertEqual(89.2277, sensor.convertToStandardized(rawValue: -0.99), accuracy: 0.0001)
    }
    
    func testTag() {
        XCTAssertEqual("LOUDNESS", sensor.tag())
    }
    
    func testRequiredResources() {
        XCTAssertEqual(ResourceType.loudness, type(of: sensor).requiredResource)
    }
    
    func testFormulaEditorSection() {
        XCTAssertEqual(.device(position: type(of: sensor).position), sensor.formulaEditorSection(for: SpriteObject()))
    }
}