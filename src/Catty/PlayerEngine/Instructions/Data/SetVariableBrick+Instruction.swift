/**
 *  Copyright (C) 2010-2017 The Catrobat Team
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

extension SetVariableBrick: CBInstructionProtocol {
    
    func instruction() -> CBInstruction {
        
        guard let spriteObject = self.script?.object,
            let variables = spriteObject.program?.variables
            else { fatalError("This should never happen!") }
        
        let userVariable = self.userVariable
        let variableFormula = self.variableFormula
        
        return CBInstruction.ExecClosure { (context, _) in
            //            self.logger.debug("Performing: SetVariableBrick")
            
            let result = variableFormula.interpretVariableDataForSprite(spriteObject)
            variables.setUserVariable(userVariable, toValue: result)
            
            //update visible userVariable
            var value = ""
            if userVariable.value is NSNumber{
                let number:NSNumber = (userVariable.value as? NSNumber)!
                value = number.stringValue
            } else if userVariable.value is NSString {
                let string:NSString = userVariable.value as! NSString
                value = string as String
            } else {
                value = ""
            }
            userVariable.textLabel.text = value
            context.state = .Runnable
        }
        
    }
}
