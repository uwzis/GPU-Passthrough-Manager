# Import dependencies
import sys, os, subprocess, re, json

def load():
    # Begin pre-initialization process
    print("Running pre-initialization process...")

    # Remove cached configuration files
    print("Deleting cached configuration files...")
    if os.path.exists("./vfio.conf"):
        os.remove("./vfio.conf")
    if os.path.exists("./data.json"):
        os.remove("./data.json")

    # Write vfio.conf template
    print("Writing vfio.conf template...")
    with open("./vfio.conf", "w") as f:
        f.write("options vfio-pci ids=")
        f.close()

    # Write data.json template
    print("Writing data.json template...")
    with open("./data.json", "w") as f:
        f.write("{}")
        f.close()

    # Get device data
    print("Gathering device data...")
    lspci_res = subprocess.check_output("lspci -nn | grep -E 'USB'", shell=True).decode("utf-8").splitlines()
    
    # Prepare device data cache
    print(f"Found {len(lspci_res)} devices. Preparing data.json payload...")
    data = {}
    data["devices"] = []
    for i in range(len(lspci_res)):
        device = {}
        device["name"] = re.search(r"]:\s[a-zA-Z0-9_ -]*.*\[", lspci_res[i]).group()[3:-2]
        device["id"] = re.search(r"[0-9,a-f]{4}:[0-9,a-f]{4}", lspci_res[i]).group()
        data["devices"].append(device)
    
    # Populate data.json
    print("Populating data.json...")
    with open("./data.json", "w") as f:
        json.dump(data, f)
        f.close()
    
    # Begin GUI initialization

if __name__ == "__main__":
    load(*sys.argv[1:])
