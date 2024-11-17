// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Ownable } from "@openzeppelin-contracts-5.0.1/access/Ownable.sol";
import { IERC20 } from "@openzeppelin-contracts-5.0.1/interfaces/IERC20.sol";
import { ISP } from "@ethsign/sign-protocol-evm/src/interfaces/ISP.sol";
import { ISPHook } from "@ethsign/sign-protocol-evm/src/interfaces/ISPHook.sol";
import { Attestation } from "@ethsign/sign-protocol-evm/src/models/Attestation.sol";

// @dev This contract manages attestation data validation logic.
contract DataValidator is Ownable {
    address public teeAccount;

    error WrongAddressCaller();

    constructor() Ownable(_msgSender()) { }

    function setTeeAccount(address _teeAccount) external onlyOwner {
        teeAccount = _teeAccount;
    }

    function _checkTeeOwner(address _attester) internal view {
        // solhint-disable-next-line custom-errors
        // require(_attester == teeAccount, WrongAddressCaller());
    }
}

// @dev This contract implements the actual schema hook.
contract DataValidatorHook is ISPHook, DataValidator {
    error UnsupportedOperation();

    function didReceiveAttestation(
        address, // attester
        uint64, // schemaId
        uint64 attestationId,
        bytes calldata // extraData
    )
        external
        payable
    {
        Attestation memory attestation = ISP(_msgSender()).getAttestation(attestationId);
        // _checkTeeOwner(attestation.attester);
    }

    function didReceiveAttestation(
        address, // attester
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        pure
    {
        revert UnsupportedOperation();
    }

    function didReceiveRevocation(
        address, // attester
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata // extraData
    )
        external
        payable
    {
        revert UnsupportedOperation();
    }

    function didReceiveRevocation(
        address, // attester
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        pure
    {
        revert UnsupportedOperation();
    }
}
