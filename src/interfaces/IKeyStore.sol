// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IKeyStore {
    function root() external view returns (uint256);
}

interface IVerifier {
    function Verify(
        bytes calldata proof,
        uint256[] calldata public_inputs
    )
        external
        view
        returns (bool);
}
