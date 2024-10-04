// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WBC} from "src/WBC/WBC.sol";

interface IGame {
    function judge() external view returns (address);
    function steal() external view returns (uint256);
    function execute() external returns (bytes32);
    function shout() external view returns (bytes memory);
}

contract Player is IGame {
    uint256 remainingGas;
    WBC private immutable wbc;

    constructor(address _wbc) {
        wbc = WBC(_wbc);
        wbc.bodyCheck();
    }

    function attack() external {
        wbc.ready();
    }

    function judge() external view returns (address) {
        return 0x0000000000000000000000000000000000000000;
    }

    function steal() external view returns (uint256) {
        uint256 o0o0o0o00oo00o0o0o0o0o0o0o0o0o0o0o0oo0o = 1001000030000000900000604030700200019005002000906;
        uint256 o0o0o0o00o0o0o0o0o0o0o0ooo0o00o0ooo000o = 460501607330902018203080802016083000650930542070;
        uint256 o0o0o00o0oo00oo00o0o0o0o0o0o0o0o0oo0o0o = 256; // 2^8
        uint256 o0oo0o0o0o0o0o0o0o0o00o0oo00o0o0o0o0o0o = 1;

        return uint160(
            o0o0o0o00oo00o0o0o0o0o0o0o0o0o0o0o0oo0o
                + o0o0o0o00o0o0o0o0o0o0o0ooo0o00o0ooo000o * o0o0o00o0oo00oo00o0o0o0o0o0o0o0o0oo0o0o
                - o0oo0o0o0o0o0o0o0o0o00o0oo00o0o0o0o0o0o
        );
    }

    function execute() external returns (bytes32) {
        remainingGas = gasleft();
        return hex"0000000000000000000000000000000000000000000009486974416E6452756E";
    }

    function shout() external view returns (bytes memory) {
        if (remainingGas - gasleft() < 25000) {
            return abi.encodePacked("I'm the best");
        } else {
            return abi.encodePacked("We are the champion!");
        }
    }
}
