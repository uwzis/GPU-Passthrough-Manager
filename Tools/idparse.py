# Import dependencies
import sys
import re

# Main function
def main(_fp, _ln = None):   
    # Initialize output variable
    _o = []

    # Open IDs list file
    _fs = open(_fp, 'r')
    _l = _fs.readlines()

    # Separate parsing methods
    if not _ln:
        # Iterate through line
        for l in _l:
            _o.append(re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", l).group())
    else:
        # Get ID from line number
        _o.append(re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", _l[int(_ln)-1]).group())

    # Output
    return ','.join(_o)

# Only run as script
if __name__ == "__main__":
    print(main(*sys.argv[1:]))
