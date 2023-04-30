import itertools
from typing import NamedTuple


class AdderInput(NamedTuple):
    a: list[int]
    b: list[int]
    c_in: int


def carry_nth(n: int, adder_input: AdderInput) -> int:
    a, b, c_in = adder_input
    if n == 0:
        return c_in
    generate = a[n - 1] and b[n - 1]
    propagate = a[n - 1] ^ b[n - 1]
    return generate or propagate and carry_nth(n - 1, adder_input)


def sum_bit(n: int, adder_input: AdderInput) -> int:
    a, b, _ = adder_input
    propagate = a[n] ^ b[n]
    return propagate ^ carry_nth(n, adder_input)


def bitarray_to_int(a: list[int]) -> int:
    """
    >>> bitarray_to_int([0])
    0
    >>> bitarray_to_int([1])
    1
    >>> bitarray_to_int([1, 1])
    3
    >>> bitarray_to_int([1, 1, 0, 1])
    11
    """
    res = 0
    for b in reversed(a):
        res *= 2
        res += b
    return res


def int_to_bitarray(x: int, l: int = 0) -> list[int]:
    """
    >>> int_to_bitarray(0, 4)
    [0, 0, 0, 0]
    >>> int_to_bitarray(1, 4)
    [1, 0, 0, 0]
    >>> int_to_bitarray(3, 4)
    [1, 1, 0, 0]
    >>> int_to_bitarray(11)
    [1, 1, 0, 1]
    """
    res = []
    while x > 0:
        res.append(x % 2)
        x //= 2
    if len(res) < l:
        res.extend([0] * (l - len(res)))
    return res


def carry_4th_gatelevel(adder_input: AdderInput) -> int:
    a, b, c_in = adder_input
    gen = [x and y for x, y in zip(a, b)]
    prop = [x ^ y for x, y in zip(a, b)]
    return (
        gen[3]
        or prop[3]
        and gen[2]
        or prop[3]
        and prop[2]
        and gen[1]
        or prop[3]
        and prop[2]
        and prop[1]
        and gen[0]
        or prop[3]
        and prop[2]
        and prop[1]
        and prop[0]
        and c_in
    )


def sum_bit_gatelevel(n: int, adder_input: AdderInput) -> int:
    a, b, c_in = adder_input
    gen = [x and y for x, y in zip(a, b)]
    prop = [x ^ y for x, y in zip(a, b)]
    if n == 0:
        return not prop[0] and c_in or prop[0] and not c_in
    elif n == 1:
        return (
            not prop[1]
            and gen[0]
            or not prop[1]
            and prop[0]
            and c_in
            or prop[1]
            and not prop[0]
            and not gen[0]
            or prop[1]
            and not gen[0]
            and not c_in
        )
    elif n == 2:
        return (
            not prop[2]
            and gen[1]
            or not prop[2]
            and prop[1]
            and gen[0]
            or not prop[2]
            and prop[1]
            and prop[0]
            and c_in
            or prop[2]
            and not prop[1]
            and not gen[1]
            or prop[2]
            and not prop[1]
            and not gen[1]
            and not c_in
            or prop[2]
            and not prop[1]
            and not gen[1]
            and not gen[0]
            or prop[2]
            and not prop[0]
            and not gen[1]
            and not gen[0]
            or prop[2]
            and not gen[1]
            and not gen[0]
            and not c_in
        )
    return (
        not prop[3]
        and gen[2]
        or not prop[3]
        and prop[2]
        and gen[1]
        or not prop[3]
        and prop[2]
        and prop[1]
        and gen[0]
        or not prop[3]
        and prop[2]
        and prop[1]
        and prop[0]
        and c_in
        or prop[3]
        and not prop[2]
        and not gen[2]
        or prop[3]
        and not prop[1]
        and not gen[2]
        and not gen[1]
        or prop[3]
        and not prop[0]
        and not gen[2]
        and not gen[1]
        and not gen[0]
        or prop[3]
        and not gen[2]
        and not gen[1]
        and not gen[0]
        and not c_in
    )


if __name__ == "__main__":
    print("[+] Testing naive implementation...")
    fail = False
    for (a_num, b_num), c_in in itertools.product(
        itertools.product(range(2**4), repeat=2), range(2)
    ):
        a = int_to_bitarray(a_num, 4)
        b = int_to_bitarray(b_num, 4)
        inp = AdderInput(a, b, c_in)
        expected = a_num + b_num + c_in
        adder_result = [sum_bit(i, inp) for i in range(4)]
        adder_result.append(carry_nth(4, inp))
        assert bitarray_to_int(adder_result) == expected
    print("[+] Implementation is correct!")
    print("[+] Testing gate_level expressions...")
    for (a_num, b_num), c_in in itertools.product(
        itertools.product(range(2**4), repeat=2), range(2)
    ):
        a = int_to_bitarray(a_num, 4)
        b = int_to_bitarray(b_num, 4)
        inp = AdderInput(a, b, c_in)
        carry_expected = carry_nth(4, inp)
        assert carry_expected == carry_4th_gatelevel(inp)
        sum_bits_expected = [sum_bit(i, inp) for i in range(4)]
        sum_bits_gatelevel = [sum_bit_gatelevel(i, inp) for i in range(4)]
        for i, (expected, got) in enumerate(zip(sum_bits_expected, sum_bits_gatelevel)):
            assert expected == got, f"a={a}, b={b}, c_in={c_in}, n={i}"
    print("[+] Expressions are correct!")
