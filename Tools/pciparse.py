# Import dependencies
import sys, re

# Main function
def main(_fp, _m, _ln = None):
    # Ensure correct processing mode
    if not _m.lower() in ["id", "name"]:
        return "Invalid mode argument (id, name)."

    # Initialize output variable
    _o = []

    # Open IDs list file
    _fs = open(_fp, 'r')
    _l = _fs.readlines()

    # Separate parsing methods
    if not _ln:
        # Iterate through line
        for l in _l:
            if _m.lower() == "id":
                _o.append(re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", l).group())
            else:
                _o.append(re.search(r"]:\s[a-zA-Z0-9_ -]*.*\[", l).group()[3:-2])
    else:
        # Get ID/name from line number
        if _m.lower() == "id":
            _o.append(re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", _l[int(_ln)-1]).group())
        else:
            _o.append(re.search(r"]:\s[a-zA-Z0-9_ -]*.*\[", _l[int(_ln)-1]).group()[3:-2])

    # Output
    return ','.join(_o)

# Only run as script
if __name__ == "__main__":
    print(main(*sys.argv[1:]))
