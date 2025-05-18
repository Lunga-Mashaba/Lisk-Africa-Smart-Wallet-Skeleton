// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Paymaster {
    event GasSponsored(address indexed user, uint256 gasLimit, bytes data);

    function sponsorGas(address user, uint256 gasLimit, bytes calldata data) external {
        emit GasSponsored(user, gasLimit, data);
    }

    receive() external payable {}
}
