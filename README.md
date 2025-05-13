🚀 DeFi Vault Protocol (Testnet MVP)
A decentralized smart contract system for lending, borrowing, and yield generation powered by ERC20 tokens. Built from scratch — no OpenZeppelin dependencies — with MetaMask and testnet support.

🧠 Overview
This DeFi vault lets users:

🔐 Deposit ERC20 tokens as collateral

💸 Borrow synthetic USD or other tokens against their deposits

📈 View their on-chain positions (deposits, borrowed amounts)

🦊 Connect and interact using MetaMask on Sepolia testnet

All deployed contracts and the frontend are built for learning, testing, and demonstrating real-world DeFi mechanics from first principles.

🏗️ Architecture
Vault Smart Contract – Manages collateral deposits, borrowing, and user positions

Custom ERC20 Token – Minted to 8B supply for vault usage

Frontend (React + ethers.js) – Connect wallet, deposit tokens, and borrow from UI

MetaMask Integration – Sign and send transactions from your browser

Chainlink Oracle-Ready – Supports future price feeds for risk management

⚙️ Features
Feature	Description
✅ ERC20 Token Support	Accepts any ERC20 token address
✅ MetaMask Integration	Connect, sign, and send txs from browser
✅ Deposits & Borrowing	Users can lock tokens and mint synthetic USD
🔄 Pool Tracking	View per-user deposit and borrow stats
💰 Lending Vault Ready	Basic mechanics for lending & vault interest
🧪 Testnet Compatible	Deployed and tested on Sepolia

📸 Screenshots

Simple interface to connect wallet, deposit, and borrow on testnet

🛠️ How to Use
🧑‍💻 1. Clone the Project
bash
Copy
Edit
git clone https://github.com/yourusername/defi-vault.git
cd defi-vault
📦 2. Install Frontend Dependencies
bash
Copy
Edit
npm install
🌐 3. Run the Frontend (Localhost)
bash
Copy
Edit
npm start
Then open http://localhost:3000 in your browser.

🦊 4. Connect MetaMask
Select Sepolia Testnet

Import test tokens (DAI, USDC, etc. on Sepolia)

Interact with Vault: deposit, borrow, view positions

🔐 Smart Contract Info
Contract	Address (Sepolia)
Vault.sol	0xYourVaultAddress
ERC20 Token	0xYourTokenAddress

📄 Verified source on Etherscan

🧠 Learnings
This project was built to deeply understand:

ERC20 mechanics without relying on OpenZeppelin

Smart contract security and deployment

Vault architecture and capital efficiency

Wallet-based UX (MetaMask, Ethers.js)

Connecting real contracts to frontend UIs

🧩 Roadmap
 Chainlink Oracle Integration

 Liquidation + Health Factor

 Yield Farming & Interest Sharing

 UI Styling with Tailwind

 Mainnet / Polygon Deployment

