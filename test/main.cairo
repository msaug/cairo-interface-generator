%lang starknet
from starkware.cairo.common.math import assert_nn, assert_not_zero
from starkware.cairo.common.cairo_builtins import HashBuiltin

struct MyStruct {
    index: felt,
}

@storage_var
func balance() -> (res: felt) {
}

@external
func increase_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    amount: felt, test_len: felt, test: MyStruct*
) {
    with_attr error_message("Amount must be positive. Got: {amount}.") {
        assert_nn(amount);
    }

    let (res) = balance.read();
    balance.write(res + amount);
    return ();
}

@view
func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    let (res) = balance.read();
    return (res,);
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    balance.write(0);
    return ();
}
