/**
 *  Copyright (C) 2010-2020 The Catrobat Team
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

final class UserListTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testInit() {
        let userList1 = UserList(name: "testList")
        var userList2 = UserList(list: userList1)

        XCTAssertTrue(userList1.isEqual(userList2))
        XCTAssertFalse(userList1 === userList2)

        userList1.add(element: 1)
        userList2 = UserList(list: userList1)

        XCTAssertEqual(userList1.name, userList2.name)
        XCTAssertFalse(userList2.value.isEqual(userList1.value))
        XCTAssertNotEqual(userList1.value.count, userList2.value.count)
        XCTAssertFalse(userList1.isEqual(userList2))
        XCTAssertFalse(userList1 === userList2)
    }

    func testMutableCopyWithContext() {
        let userList = UserList(name: "testList")

        let context = CBMutableCopyContext()
        XCTAssertEqual(0, context.updatedReferences.count)

        let userListCopy = userList.mutableCopy(with: context) as! UserList
        XCTAssertEqual(userList.name, userListCopy.name)
        XCTAssertTrue(userList === userListCopy)
    }

    func testMutableCopyAndUpdateReference() {
        let userListA = UserList(name: "userList")
        let userListB = UserList(name: "userList")

        let context = CBMutableCopyContext()
        context.updateReference(userListA, withReference: userListB)
        XCTAssertEqual(1, context.updatedReferences.count)

        let userListCopy = userListA.mutableCopy(with: context) as! UserList
        XCTAssertEqual(userListA.name, userListCopy.name)
        XCTAssertFalse(userListA === userListCopy)
        XCTAssertTrue(userListB === userListCopy)
    }

    func testIsEqual() {
        let listA = UserList(name: "userList")
        let listB = UserList(name: "userList")

        listA.add(element: 50)
        listB.add(element: 50)
        listA.add(element: "item")
        listB.add(element: "itemB")
        XCTAssertFalse(listB.isEqual(listA))

        listB.replace(at: 2, with: "item")
        XCTAssertTrue(listB.isEqual(listA))

    }

    func testIsEqualToUserListForSameValueDifferentName() {
        let userListA = UserList(name: "userList")
        let userListB = UserList(name: "userListB")
        let userListC = UserList(name: "userList")

        userListA.add(element: 50)
        userListB.add(element: 50)
        userListC.add(element: 50)
        userListA.add(element: "item")
        userListB.add(element: "item")
        userListC.add(element: "item")

        XCTAssertFalse(userListB.isEqual(userListA))
        XCTAssertTrue(userListC.isEqual(userListA))
    }

    func testAdd() {
        let list1 = UserList(name: "testName")

        list1.add(element: 10)
        list1.add(element: 20)

        let value = list1.value

        XCTAssertEqual(2, value.count)
        XCTAssertEqual(value[0] as! Int, 10)
        XCTAssertEqual(value[1] as! Int, 20)
    }

    func testDelete() {
        let list1 = UserList(name: "testName")

        list1.add(element: 10)
        list1.add(element: 20)

        var value = list1.value

        XCTAssertEqual(2, value.count)

        list1.delete(at: 2)
        value = list1.value

        XCTAssertEqual(1, value.count)
        XCTAssertEqual(value[0] as! Int, 10)
    }

    func testDeleteInvalidIndex() {
        let list1 = UserList(name: "testName")

        list1.add(element: 10)
        list1.add(element: 20)

        var value = list1.value
        XCTAssertEqual(2, value.count)

        list1.delete(at: 3)
        value = list1.value
        XCTAssertEqual(2, value.count)

        list1.delete(at: 0)
        value = list1.value
        XCTAssertEqual(2, value.count)
    }

    func testInsert() {
        let list1 = UserList(name: "testName")

        list1.insert(element: 10, at: 1)
        list1.insert(element: 30, at: 2)

        var value = list1.value

        XCTAssertEqual(value.count, 2)
        XCTAssertEqual(value[0] as! Int, 10)
        XCTAssertEqual(value[1] as! Int, 30)

        list1.insert(element: 20, at: 2)

        value = list1.value

        XCTAssertEqual(value.count, 3)
        XCTAssertEqual(value[0] as! Int, 10)
        XCTAssertEqual(value[1] as! Int, 20)
        XCTAssertEqual(value[2] as! Int, 30)
    }

    func testInsertWithInvalidIndex() {
        let list1 = UserList(name: "testName1")

        list1.insert(element: 10, at: -1)
        var value = list1.value

        XCTAssertEqual(value.count, 0)

        list1.insert(element: 20, at: 2)
        value = list1.value

        XCTAssertEqual(value.count, 0)
    }

    func testReplace() {
        let list1 = UserList(name: "testName1")

        list1.insert(element: 10, at: 1)
        list1.insert(element: 20, at: 2)
        list1.replace(at: 2, with: 30)

        var value = list1.value

        XCTAssertEqual(value.count, 2)
        XCTAssertEqual(value[0] as! Int, 10)
        XCTAssertEqual(value[1] as! Int, 30)

        list1.replace(at: 1, with: 40)

        value = list1.value

        XCTAssertEqual(value.count, 2)
        XCTAssertEqual(value[0] as! Int, 40)
        XCTAssertEqual(value[1] as! Int, 30)
    }

    func testReplaceInvalidIndex() {
        let list1 = UserList(name: "testName1")

        list1.insert(element: 10, at: 1)
        list1.replace(at: 1, with: 40)

        let value = list1.value

        XCTAssertNotEqual(value[0] as! Int, 30)
    }
}
