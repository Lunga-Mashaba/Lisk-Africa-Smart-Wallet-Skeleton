// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SmartWallet - A minimal EIP-4337-style wallet
contract SmartWallet {
    address public owner;
    uint256 public nonce;

    event Executed(address to, uint256 value, bytes data);

    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    /// @notice Execute a transaction from this wallet
    function execute(address to, uint256 value, bytes calldata data) external onlyOwner {
        (bool success, ) = to.call{value: value}(data);
        require(success, "Call failed");
        emit Executed(to, value, data);
        nonce++;
    }

    /// @notice Simulates a user operation signature check (mock)
    /// @dev Parameters are unused but kept for interface compatibility
    function validateUserOp(bytes32 /*userOpHash*/, bytes calldata /*signature*/) external view returns (bool) {
        // Simulated check: always true if caller is owner
        return msg.sender == owner;
    }

    receive() external payable {}
}
