// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice(
        AggregatorV3Interface _priceFeed
    ) internal view returns (uint256) {
        (, int price, , , ) = _priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function priceConvertionRate(
        uint256 _ethAmount,
        AggregatorV3Interface _priceFeed
    ) internal view returns (uint256 ethAmountToUsd) {
        uint256 ethPrice = getPrice(_priceFeed);
        ethAmountToUsd = (ethPrice * _ethAmount) / 1e18;
    }
}
 