# Import dependencies
import sys, re

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
            _o.append(re.search(r"]:\s[a-zA-Z0-9_ -]*.*\[", l).group()[3:-2])
    else:
        # Get ID from line number
        _o.append(re.search(r"]:\s[a-zA-Z0-9_ -]*.*\[", _l[int(_ln)-1]).group()[3:-2])

    # Output
    return ','.join(_o)

# Only run as script
if __name__ == "__main__":
    print(main(*sys.argv[1:]))