import sys
args = sys.argv
Input_Path=args[1]
Output_Path=args[2]

sm_column=[]
mn=[]
lines=open(Input_Path, "r").readlines()
Output=open(Output_Path, "x")
for i,line in enumerate(lines):
    if "starting_magnetization"in line:
        sm_column.append(i)
    if "ATOMIC_SPECIES" in line:
        for j in range(len(sm_column)):
            mn.append(lines[i+j+1].split()[0])

for i in range(len(mn)):
    if (mn[i] == "Cr") or (mn[i] == "V"):
        lines[sm_column[i]]="\tstarting_magnetization({}) = 3.0\n".format(i+1)
    elif (mn[i] == "Fe") or (mn[i] == "Co"):
        lines[sm_column[i]]="\tstarting_magnetization({}) = -3.0\n".format(i+1)
    else :
        lines[sm_column[i]]="\tstarting_magnetization({}) = 0.0\n".format(i+1)

for line in lines: Output.write(line)

