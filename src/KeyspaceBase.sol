// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { IKeyStore, IVerifier } from "src/interfaces/IKeyStore.sol";

abstract contract KeyspaceBase {
    IKeyStore public immutable keyStore;
    IVerifier public immutable stateVerifier;

    constructor(address _keyStore, address _stateVerifier) {
        keyStore = IKeyStore(_keyStore);
        stateVerifier = IVerifier(_stateVerifier);
    }

    function _validateConfigOnKeyStore(
        bytes memory stateProof,
        uint256 keyInput,
        uint256[] memory data
    )
        internal
        view
        returns (bool)
    {
        uint256[] memory publicInputs = new uint256[](3);
        publicInputs[0] = keyInput;
        publicInputs[1] = keyStore.root();
        publicInputs[2] = uint256(keccak256(abi.encodePacked(data)) >> 8);
        return stateVerifier.Verify(stateProof, publicInputs);
    }
}
