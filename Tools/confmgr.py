# Import dependencies
import sys, re

# Main function
def main(_fp, _c, _id):
    # Open config file
    _fs = open(_fp, 'r')
    _b = _fs.read()
    _fs.close()

    # Manage commands
    if _c == "add":
        try:
            with open(_fp, 'a') as w:
                if _b[-1] == "=":
                    w.write(f'{_id}')
                else:
                    w.write(f',{_id}')
                w.close()
                return f"Added {_id} to {_fp}."
        except:
            return f"Failed to add {_id} to {_fp}."
    elif _c == "remove":
        if f',{_id}' in _b:
            with open(_fp, 'w') as w:
                w.seek(0)
                w.write(_b.replace(f',{_id}',''))
                w.close()
                return f"Removed {_id} from {_fp}."
        elif f'={_id},' in _b:
            with open(_fp, 'w') as w:
                w.seek(0)
                w.write(_b.replace(f'{_id},',''))
                w.close()
                return f"Removed {_id} from {_fp}."
        elif _id in _b:
            with open(_fp, 'w') as w:
                w.seek(0)
                w.write(_b.replace(_id,''))
                w.close()
                return f"Removed {_id} from {_fp}."
        
        else:
            return f"Failed: {_id} not found in {_fp}."
    else:
        return "Failed: invalid command"

# Only run as script            
if __name__ == "__main__":
    print(main(*sys.argv[1:]))