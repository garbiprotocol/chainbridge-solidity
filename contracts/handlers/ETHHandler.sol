// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity 0.8.11;
pragma experimental ABIEncoderV2;

import "../interfaces/IBridge.sol";
import "../interfaces/IDepositExecute.sol";
import "./HandlerHelpers.sol";

contract ETHHandler is IDepositExecute, HandlerHelpers {
    /**
        @param bridgeAddress Contract address of previously deployed Bridge.
     */
    constructor(
        address          bridgeAddress
    ) public HandlerHelpers(bridgeAddress) {
    }

    
    function deposit(
        bytes32 resourceID,
        address depositer,
        bytes   calldata data
    ) external override onlyBridge returns (bytes memory) {
        uint256        amount;
        (amount) = abi.decode(data, (uint));
        require(amount == address(_bridgeAddress).balance, "Not Enough ETH balance");

        address tokenAddress = _resourceIDToTokenContractAddress[resourceID];
        require(_contractWhitelist[tokenAddress], "provided tokenAddress is not whitelisted");
        
        IBridge(_bridgeAddress).moveETHtoHandler(resourceID);
    }

    function executeProposal(bytes32 resourceID, bytes calldata data) external override onlyBridge {
        uint256       amount;
        uint256       lenDestinationRecipientAddress;
        bytes  memory destinationRecipientAddress;

        (amount, lenDestinationRecipientAddress) = abi.decode(data, (uint, uint));
        destinationRecipientAddress = bytes(data[64:64 + lenDestinationRecipientAddress]);

        bytes20 recipientAddress;
        address tokenAddress = _resourceIDToTokenContractAddress[resourceID];

        assembly {
            recipientAddress := mload(add(destinationRecipientAddress, 0x20))
        }

        require(_contractWhitelist[tokenAddress], "provided tokenAddress is not whitelisted");

        payable(address(recipientAddress)).transfer(amount);
    }

    function withdraw(bytes memory data) external override onlyBridge {
        address tokenAddress;
        address recipient;
        uint amount;

        (tokenAddress, recipient, amount) = abi.decode(data, (address, address, uint));

        payable(recipient).transfer(amount);
    }

    receive() external payable {}
}
