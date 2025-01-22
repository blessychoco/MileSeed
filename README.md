# MileSeed

MileSeed is a decentralized grant distribution platform built on the Stacks blockchain, enabling organizations to create Bitcoin-backed grant pools and distribute funds based on milestone completion.

## Key Features

- Create and manage grant pools backed by SIP-010 compliant tokens
- Submit milestone-based grant proposals
- Community-driven proposal voting system
- Milestone verification and fund distribution
- Comprehensive validation and security checks

## Technical Overview

### Smart Contract Architecture

The smart contract implements several key components:

#### Data Structures

1. **Grant Pools**
```clarity
{
    owner: principal,
    total-amount: uint,
    remaining-amount: uint,
    token-contract: principal,
    active: bool
}
```

2. **Proposals**
```clarity
{
    applicant: principal,
    pool-id: uint,
    requested-amount: uint,
    status: (string-ascii 20),
    milestones: (list 5 {...})
}
```

3. **Votes**
```clarity
{
    proposal-id: uint,
    voter: principal,
    in-favor: bool
}
```

#### Core Functions

1. `create-grant-pool`: Creates a new grant pool
   - Validates token contract
   - Enforces amount limits
   - Verifies owner permissions

2. `submit-proposal`: Submits a grant proposal
   - Validates pool existence and status
   - Checks amount constraints
   - Verifies milestone structure

3. `vote-on-proposal`: Enables voting on proposals
   - Prevents double voting
   - Validates proposal status
   - Records vote

4. `complete-milestone`: Manages milestone completion
   - Verifies applicant authorization
   - Validates milestone index
   - Handles fund distribution

### Security Features

1. **Input Validation**
   - Amount range checks
   - Pool and proposal ID validation
   - Milestone structure verification

2. **Access Control**
   - Owner-only pool creation
   - Applicant-only milestone completion
   - Single vote per proposal per address

3. **State Management**
   - Active pool status tracking
   - Proposal state transitions
   - Milestone completion tracking

## Development Setup

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) installed
- Node.js and npm (for testing)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/blessychoco/MileSeed.git
cd mileseed
```

2. Install dependencies:
```bash
npm install
```

### Testing

Run the test suite:
```bash
clarinet test
```

## Usage Examples

### Creating a Grant Pool
```clarity
(contract-call? .mileseed create-grant-pool 
    u1000000 
    'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-contract)
```

### Submitting a Proposal
```clarity
(contract-call? .mileseed submit-proposal
    u1
    u100000
    (list 
        {
            description: "Research Phase",
            amount: u30000,
            completed: false
        }
        {
            description: "Development",
            amount: u70000,
            completed: false
        }
    ))
```

### Voting on a Proposal
```clarity
(contract-call? .mileseed vote-on-proposal u1 true)
```

## Error Handling

The contract defines several error codes:
- `err-owner-only (u100)`: Unauthorized access
- `err-not-found (u101)`: Resource not found
- `err-unauthorized (u102)`: Insufficient permissions
- `err-invalid-state (u103)`: Invalid state transition
- `err-insufficient-funds (u104)`: Insufficient pool funds
- `err-invalid-amount (u105)`: Amount validation failed
- `err-invalid-milestone (u107)`: Invalid milestone data

## Development Roadmap

### Phase 1: Core Features ✅
- Smart contract implementation
- Basic validation and security
- Grant pool management
- Proposal submission
- Voting system

### Phase 2: Enhanced Features 🚧
- Multi-signature support
- Advanced milestone verification
- Token standard integration
- Enhanced voting mechanisms

### Phase 3: Integration & UI 📋
- Web interface
- Wallet integration
- Analytics dashboard
- Documentation portal

## Contributing

1. Fork the repository
2. Create a feature branch
3. Implement changes
4. Add tests
5. Submit a pull request

## Security Considerations

- All user inputs are validated
- Amount limits are enforced
- Access controls are implemented
- State transitions are verified
- Double-voting is prevented
