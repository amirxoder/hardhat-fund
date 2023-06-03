// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./PriceConvertor.sol";

error FundMe__NotEnough();
error FundMe__CallFailed();
error FundMe__NotOwner();

/**
 * @title A contract for crowd funding
 * @author AmirCoodder || amircodder
 * @notice This contract is to demo a sample funding contract
 * @dev This implements price feed as our library
 */

contract FundMe {
    // Type Declarations
    using PriceConvertor for uint256;

    // State Variables
    uint256 private constant MINIMUM_USD = 50 * 1e18;
    address public immutable i_owner;
    address[] public funders;
    mapping(address => uint256) public addressToAmountUsd;
    AggregatorV3Interface public priceFeed;

    // Events
    event FundIn(address funder, uint256 amountUsd);
    event Withdraw(address _to, uint256 amount);

    // Modifiers
    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    // Funcitons order:
    /// constructor
    /// receive
    /// fallback
    /// external
    /// public
    /// internal
    /// private
    /// view / pure

    constructor(address _priceFeed) {
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    /**
     * @notice this function fund this contract
     */

    function fund() public payable {
        if (msg.value.priceConvertionRate(priceFeed) <= MINIMUM_USD)
            revert FundMe__NotEnough();
        funders.push(msg.sender);
        addressToAmountUsd[msg.sender] = msg.value;
        emit FundIn(msg.sender, msg.value);
    }

    function withdraw() public {
        for (uint256 i; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountUsd[funder] = 0;
        }
        funders = new address[](0);
        (bool success, ) = payable(i_owner).call{value: address(this).balance}(
            ""
        );
        if (!success) revert FundMe__CallFailed();
        emit Withdraw(msg.sender, address(this).balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
