// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {HelloWorldBase, HelloWorld} from "src/HelloWorld/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorldBase public base;

    function setUp() external {
        uint256 startTime = block.timestamp + 60;
        uint256 endTime = startTime + 60;
        uint256 fullScore = 100;
        base = new HelloWorldBase(startTime, endTime, fullScore);
        base.setup();
    }

    function testExploit() public {
        HelloWorld helloWorld = base.helloWorld();
        helloWorld.answer("HelloWorld");

        base.solve();
        assertTrue(base.isSolved());
    }
}
