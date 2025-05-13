// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Simplified price oracle
contract TheGreenTech {
    mapping(address => uint256) public prices; // price in USD with 18 decimals

    function setPrice(address token, uint256 priceInUsd) external {
        prices[token] = priceInUsd;
    }

    function getPrice(address token) external view returns (uint256) {
        return prices[token];
    }
}

/// @notice DeFi Vault with Oracle-based Lending Logic
contract DeFiVault {
    address public owner;
    TheGreenTech public oracle;

    uint256 public constant COLLATERAL_RATIO = 60; // 60% LTV

    struct DepositInfo {
        uint256 depositedAmount;
        address tokenAddress;
        uint256 borrowedAmount;
    }

    mapping(address => DepositInfo) public userDeposits;

    constructor(address _oracle) {
        owner = msg.sender;
        oracle = TheGreenTech(_oracle);
    }

    /// @notice User deposits collateral token
    function depositCollateral(address token, uint256 amount) external {
        require(amount > 0, "Invalid amount");
        require(ERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer failed");

        userDeposits[msg.sender].depositedAmount += amount;
        userDeposits[msg.sender].tokenAddress = token;

        emit CollateralDeposited(msg.sender, token, amount);
    }

    /// @notice User borrows stablecoin against collateral
    function borrow(uint256 amountUsd) external {
        DepositInfo storage user = userDeposits[msg.sender];
        require(user.depositedAmount > 0, "No deposit");
        uint256 tokenPrice = oracle.getPrice(user.tokenAddress); // USD per token

        uint256 collateralValueUsd = (user.depositedAmount * tokenPrice) / 1e18;
        uint256 maxBorrowUsd = (collateralValueUsd * COLLATERAL_RATIO) / 100;

        require(amountUsd <= maxBorrowUsd - user.borrowedAmount, "Exceeds LTV");

        user.borrowedAmount += amountUsd;

        // Simulated: in real systems you'd mint a stablecoin like DAI here
        emit Borrowed(msg.sender, amountUsd);
    }

    /// @notice Repay stablecoin debt
    function repay(uint256 amountUsd) external {
        userDeposits[msg.sender].borrowedAmount -= amountUsd;
        emit Repaid(msg.sender, amountUsd);
    }

    /// @notice Withdraw collateral if health is OK
    function withdrawCollateral(uint256 amount) external {
        DepositInfo storage user = userDeposits[msg.sender];
        require(user.depositedAmount >= amount, "Not enough");

        uint256 remainingCollateral = user.depositedAmount - amount;
        uint256 tokenPrice = oracle.getPrice(user.tokenAddress);
        uint256 remainingUsd = (remainingCollateral * tokenPrice) / 1e18;

        uint256 requiredUsd = (user.borrowedAmount * 100) / COLLATERAL_RATIO;
        require(remainingUsd >= requiredUsd, "Health too low");

        user.depositedAmount -= amount;
        require(ERC20(user.tokenAddress).transfer(msg.sender, amount), "Withdraw failed");

        emit CollateralWithdrawn(msg.sender, amount);
    }

    // Events
    event CollateralDeposited(address indexed user, address token, uint256 amount);
    event Borrowed(address indexed user, uint256 usdAmount);
    event Repaid(address indexed user, uint256 usdAmount);
    event CollateralWithdrawn(address indexed user, uint256 amount);
}

interface ERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
