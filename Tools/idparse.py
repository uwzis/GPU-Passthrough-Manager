# Import dependencies
import sys
import re

def main(_fp):   
    # Initialize output variable
    _o = []

    # Open IDs list file
    _fs = open(_fp, 'r')
    _l = _fs.readlines()
    for l in _l:
        _o.append(re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", l).group())

    # Output
    print(','.join(_o))

# Only run directly
if __name__ == "__main__":
    main(sys.argv[1])
    sys.exit(0)
