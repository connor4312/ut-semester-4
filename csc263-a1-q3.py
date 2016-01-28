from math import ceil, floor
import random
import time
import sys

def alloc_array(n):
    return [0x000] * n

def get_midpoint(n):
    return len(n) / 2

# Generator function for parents of the node at the index.
def get_parents_of(n, index):
    mid = get_midpoint(n)

    while index != mid:
        delta = (mid - index) / 2.0

        if index < mid:
            is_right = index % 2 == 0
            index += int(ceil(delta))
        else:
            is_right = index % 2 == 1
            index += int(floor(delta))

        yield (index, is_right)

# Gets the child of the item at the index. Left by default, right if passed.
def get_child_of(n, index, right=False):
    mid = get_midpoint(n)
    if index == mid:
        if right:
            return mid + 1
        else:
            return mid - 1

    ch = mid + (index - mid) * 2
    if right:
        ch += 1

    return ch


# Returns whether n is a member of the array.
def is_member(n, item):
    return n[item] & 0x010

# Returns the maximum number of elements from the array.
def maximum(n):
    item = get_midpoint(n)
    print('===')
    print(["{0:b}".format(i) for i in n])
    while True:
        print(item, len(n))
        if n[item] & 0x001:
            item = get_child_of(n, item, right=True)
        elif n[item] & 0x010:
            return item
        elif n[item] & 0x100:
            item = get_child_of(n, item, right=False)
        else:
            raise Exception('empty tree')

# Inserts an item into the set
def insert(n, item):
    n[item] |= 0x010 # turn "on" the item
    print('setting', item)
    # Activate all parents
    for (parent, is_right) in get_parents_of(n, item):
        print(parent, is_right)
        if is_right:
            n[parent] |= 0x001
        else:
            n[parent] |= 0x100


# Removes an item from the set
def delete(n, item):
    print('deleting', item)
    n[item] &= 0x101

    # still have children? do nothing
    if n[item] != 0x000: return

    for (parent, is_right) in get_parents_of(n, item):
        # Remove the current node from the parent's tree.
        if is_right:
            n[parent] &= 0x110
        else:
            n[parent] &= 0x011

        # If the parent isn't empty, stop. Otherwise keep looping
        # up destroying nodes.
        if n[parent] != 0x000:
            return


if __name__ == '__main__':
    total = 0
    for n in range(10000):
        # l = 2 ** random.randint(1, 10)
        l = 8
        total += l
        n = alloc_array(l)
        ex = []
        for i in range(l):
            if random.random() < 0.5:
                insert(n, i)
                print(["{0:b}".format(j) for j in n])
                ex.append(i)

        while len(ex) > 0:
            for x in range(l):
                in_ex = x in ex
                is_mem = is_member(n, x)
                if in_ex and not is_mem:
                    raise Exception('expected %d, but did not get' % x)
                elif not in_ex and is_mem:
                    raise Exception('deleted %d, but got it anyway' % x)

                if in_ex and random.random() < 0.5:
                    delete(n, x)
                    ex.remove(x)

                if len(ex) > 0 and max(ex) != maximum(n):
                    print(ex, ["{0:b}".format(i) for i in n])
                    raise Exception('got wrong max, expected %d, got %d' % (max(ex), maximum(n)))

    print("Tested a total of %d items without failures" % total)
