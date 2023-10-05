from sys import argv
import subprocess
import re

_,s = argv
RED='\033[0;31m'
GREEN='\033[0;32m' 
BOLD = '\033[1m'
NC='\033[0m'

n = subprocess.run(["apt", "search", s],text=True,capture_output=True)
pac_name = re.sub(r"(\/.*)","",n.stdout)
pac_name = re.sub(r"(  .*)","",pac_name)
pac_name = re.sub(r"\n\n\n","\n",pac_name)
list_names = pac_name.split('\n')

list_names.pop(0)
list_names.pop(0)
list_names.pop(-1)

pac_disc = re.sub("(.*\/.*)", "",n.stdout)
pac_disc = re.sub(r"\n\n\n","\n",pac_disc)
list_disc = pac_disc.split('\n')
nl = list_disc[3:-2]
i =0
if len(list_names) ==0:
  quit(RED+BOLD+"E: "+NC+"No package found found")

elif len(list_names) == 1:
  print(f"One package found\nInstalling ",list_names[0]," pleese wait...\n")
  subprocess.run(["sudo","apt","install",list_names[0],"-y"])
  quit()
else:
  print(f"List of packages contains {s}:")  
  
for f in nl:
  print(f"{i}|",list_names[i],":",f)
  i+=1
try:
    x=int(input(f"\nPlease enter number[0-{i-1}]: "))
except KeyboardInterrupt:
    quit()


print("\n",list_names[x])
subprocess.run(["sudo","apt","install",list_names[x],"-y"])