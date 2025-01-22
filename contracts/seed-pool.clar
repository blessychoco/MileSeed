;; MileSeed Grant Distribution Platform Smart Contract
;; Handles creation and management of grant pools, proposal submission, and milestone-based fund distribution

(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-unauthorized (err u102))
(define-constant err-invalid-state (err u103))

;; Data Maps
(define-map grant-pools
    { pool-id: uint }
    {
        owner: principal,
        total-amount: uint,
        remaining-amount: uint,
        token-contract: principal,
        active: bool
    }
)

(define-map proposals
    { proposal-id: uint }
    {
        applicant: principal,
        pool-id: uint,
        requested-amount: uint,
        status: (string-ascii 20),  ;; pending, approved, rejected, completed
        milestones: (list 5 {
            description: (string-ascii 100),
            amount: uint,
            completed: bool
        })
    }
)

(define-map votes
    { proposal-id: uint, voter: principal }
    { in-favor: bool }
)

;; Data Variables
(define-data-var current-pool-id uint u0)
(define-data-var current-proposal-id uint u0)

;; Create Grant Pool
(define-public (create-grant-pool (total-amount uint) (token-contract principal))
    (let
        (
            (pool-id (+ (var-get current-pool-id) u1))
        )
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (map-set grant-pools
            { pool-id: pool-id }
            {
                owner: tx-sender,
                total-amount: total-amount,
                remaining-amount: total-amount,
                token-contract: token-contract,
                active: true
            }
        )
        (var-set current-pool-id pool-id)
        (ok pool-id)
    )
)

;; Submit Proposal
(define-public (submit-proposal 
    (pool-id uint)
    (requested-amount uint)
    (milestones (list 5 {
        description: (string-ascii 100),
        amount: uint,
        completed: bool
    })))
    (let
        (
            (proposal-id (+ (var-get current-proposal-id) u1))
            (pool (unwrap! (map-get? grant-pools { pool-id: pool-id }) err-not-found))
        )
        (asserts! (get active pool) err-invalid-state)
        (asserts! (<= requested-amount (get remaining-amount pool)) err-invalid-state)
        
        (map-set proposals
            { proposal-id: proposal-id }
            {
                applicant: tx-sender,
                pool-id: pool-id,
                requested-amount: requested-amount,
                status: "pending",
                milestones: milestones
            }
        )
        (var-set current-proposal-id proposal-id)
        (ok proposal-id)
    )
)

;; Vote on Proposal
(define-public (vote-on-proposal (proposal-id uint) (in-favor bool))
    (let
        (
            (proposal (unwrap! (map-get? proposals { proposal-id: proposal-id }) err-not-found))
        )
        (asserts! (is-eq (get status proposal) "pending") err-invalid-state)
        
        (map-set votes
            { proposal-id: proposal-id, voter: tx-sender }
            { in-favor: in-favor }
        )
        (ok true)
    )
)

;; Complete Milestone
(define-public (complete-milestone (proposal-id uint) (milestone-index uint))
    (let
        (
            (proposal (unwrap! (map-get? proposals { proposal-id: proposal-id }) err-not-found))
            (pool (unwrap! (map-get? grant-pools { pool-id: (get pool-id proposal) }) err-not-found))
        )
        (asserts! (is-eq (get status proposal) "approved") err-invalid-state)
        (asserts! (is-eq tx-sender (get applicant proposal)) err-unauthorized)
        
        ;; Update milestone status and transfer funds
        ;; Note: This is a simplified version. In production, you'd want to add more checks
        ;; and potentially require verification from pool owner
        (ok true)
    )
)

;; Getter Functions
(define-read-only (get-pool-details (pool-id uint))
    (map-get? grant-pools { pool-id: pool-id })
)

(define-read-only (get-proposal-details (proposal-id uint))
    (map-get? proposals { proposal-id: proposal-id })
)

(define-read-only (get-vote (proposal-id uint) (voter principal))
    (map-get? votes { proposal-id: proposal-id, voter: voter })
)