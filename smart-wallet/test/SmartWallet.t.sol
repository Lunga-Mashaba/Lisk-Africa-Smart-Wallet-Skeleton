// SPDX-L// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// ✅ Import Test and stdCheats from forge-std
import "forge-std/Test.sol";

// ✅ Import your wallet contract
import "../src/SmartWallet.sol";

contract SmartWalletTest is Test {
    SmartWallet wallet;
    address owner = address(0xABCD);

    function setUp() public {
        // Simulate contract deployment by owner
        vm.prank(owner);
        wallet = new SmartWallet(owner);
    }

    function testExecuteETHTransfer() public {
        address payable recipient = payable(address(0x1234));

        // Fund the wallet with 1 ETH
        vm.deal(address(wallet), 1 ether);

        // Have the owner call the execute function
        vm.prank(owner);
        wallet.execute(recipient, 0.5 ether, "");

        // Assert the balance was transferred
        assertEq(recipient.balance, 0.5 ether);
    }

    function testNonceIncrements() public {
        vm.prank(owner);
        wallet.execute(address(0x1), 0, "");

        assertEq(wallet.nonce(), 1);
    }

    function testValidateUserOp() public {
        vm.prank(owner);
        bool valid = wallet.validateUserOp(keccak256("dummy"), "0x");
        assertTrue(valid);
    }
}
