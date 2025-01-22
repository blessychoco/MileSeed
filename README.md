# MileSeed

MileSeed is a decentralized grant distribution platform built on the Stacks blockchain, enabling organizations to create Bitcoin-backed grant pools and distribute funds based on milestone completion. The platform leverages smart contracts to ensure transparent and efficient grant management while utilizing Bitcoin's security through the Stacks blockchain.

## Features

- **Grant Pool Creation**: Organizations can create grant pools backed by Bitcoin or supported tokens
- **Smart Contract Proposals**: Applicants submit proposals as smart contracts with defined milestones
- **Milestone-Based Distribution**: Funds are released in stages as project milestones are completed
- **Community Governance**: Integrated voting mechanism for grant allocation
- **Verification System**: Built-in proof of development/research milestone verification
- **Bitcoin Security**: Leverages Bitcoin's security through Stacks blockchain

## Smart Contract Structure

The platform consists of the following main components:

### Data Structures

1. **Grant Pools**: Stores information about available grant pools including:
   - Total amount
   - Remaining amount
   - Token contract
   - Pool status

2. **Proposals**: Manages grant proposals with:
   - Applicant information
   - Requested amount
   - Milestone definitions
   - Proposal status

3. **Votes**: Tracks community votes on proposals

### Main Functions

1. `create-grant-pool`: Creates a new grant pool with specified funding
2. `submit-proposal`: Submits a new grant proposal with milestones
3. `vote-on-proposal`: Enables community voting on proposals
4. `complete-milestone`: Marks milestones as complete and triggers fund distribution

## Getting Started

### Prerequisites

- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm (for testing and deployment scripts)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/blessychoco/MileSeed.git
cd MileSeed
```

2. Install dependencies:
```bash
npm install
```

3. Deploy the contract:
```bash
clarinet contract deploy
```

### Usage

#### Creating a Grant Pool

```clarity
(contract-call? .mileseed create-grant-pool u1000000 'SP000...)
```

#### Submitting a Proposal

```clarity
(contract-call? .mileseed submit-proposal u1 u100000 
    (list 
        {description: "Initial Research", amount: u20000, completed: false}
        {description: "MVP Development", amount: u30000, completed: false}
        {description: "Final Delivery", amount: u50000, completed: false}
    )
)
```

## Security Considerations

- Implement thorough testing before mainnet deployment
- Consider adding time-locks for fund distribution
- Add multi-sig requirements for large grants
- Include emergency pause functionality
- Implement proper access control mechanisms

## Development Roadmap

### Phase 1: Core Implementation
- [x] Basic smart contract implementation
- [x] Grant pool creation
- [x] Proposal submission
- [x] Voting mechanism

### Phase 2: Enhanced Features
- [ ] Multi-signature support
- [ ] Advanced milestone verification
- [ ] Integration with external data sources
- [ ] Enhanced voting mechanisms

### Phase 3: UI/UX Development
- [ ] Web interface development
- [ ] Mobile responsiveness
- [ ] Wallet integration
- [ ] Analytics dashboard

## Contributing

We welcome contributions to MileSeed! Please follow these steps:

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request


## Acknowledgments

- Stacks Foundation
- Bitcoin community
- All contributors and supporters