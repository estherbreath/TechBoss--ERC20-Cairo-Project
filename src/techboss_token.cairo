// use starknet::ContractAddress;

#[starknet::contract]
mod TechBossERC20{
    //libraries and variables
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use starknet::contract_sddress_const; //like an address zero
    use core::zeroable::zeroable;
    use super::IERC20;

 //Stroge Variables
    #[storage]
    struct Storage {
        name: felt252,
        symbol: felt252,
        decimals: u8,
        total_supply: u256,
        balances: LegacyMap<ContractAddress, u256>,
        allowances: LegacyMap<
            (ContractAddress, ContractAddress), u256
        >, //similar to mapping(address => mapping(address => uint256))
    }

    //event
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Approval: Approval,
        Transfer: Transfer
    }

     #[derive(Drop, starknet::Event)]
    struct Transfer {
        from: ContractAddress,
        to: ContractAddress,
        value: u256
    }

    #[derive(Drop, starknet::Event)]
    struct Approval {
        owner: ContractAddress,
        spender: ContractAddress,
        value: u256,
    }

    // Constructor 
    #[constructor]
    fn constructor(ref self: ContractState, // _name: felt252,
     // _symbol: felt252,
    // _decimal: u8,
    // _initial_supply: u256,
    recipient: ContractAddress) {
        // The .is_zero() method here is used to determine whether the address type recipient is a 0 address, similar to recipient == address(0) in Solidity.
        assert(!recipient.is_zero(), 'transfer to zero address');
        self.name.write('BlockheaderToken');
        self.symbol.write('BHT');
        self.decimals.write(18);
        self.total_supply.write(1000000);
        self.balances.write(recipient, 1000000);

        self
            .emit(
                Transfer { //Here, `contract_address_const::<0>()` is similar to address(0) in Solidity
                    from: contract_address_const::<0>(), to: recipient, value: 1000000
                }
            );
    }

    

}