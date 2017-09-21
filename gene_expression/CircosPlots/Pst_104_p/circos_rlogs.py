import os
import sys

# -----------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------
input_file = file('Pst104_Clusters_Secretome.txt', 'r')
content = input_file.readlines()
input_file.close()
# -----------------------------------------------------------------------------------------------------------
def writefile(FILENAME, INDEX):
    output = open(FILENAME,'w')

    start = 0

    cluster_start = {
    '1' : 0,
    '2' : 148,
    '3' : 148+274,
    '4' : 148+274+227,
    '5' : 148+274+227+278,
    '6' : 148+274+227+278+291,
    '7' : 148+274+227+278+291+60,
    '8' : 148+274+227+278+291+60+280}


    # colors: from light to dark color=(R,G,B)
    #['rgb(255,255,217)','rgb(237,248,177)','rgb(199,233,180)','rgb(127,205,187)','rgb(65,182,196)','rgb(29,145,192)','rgb(34,94,168)','rgb(37,52,148)','rgb(8,29,88)']
    #-10:-7.78
    #-7.78:-5.56
    #-5.56:-3.34
    #-3.34:-1.12
    #-1.12:1.1
    #1.1:3.32
    #3.32:5.54
    #5.54:7.76
    #7.76:10.0

    for line in content[1:]:
        cluster = line.split()[-1]
        
        entry = line.split()[INDEX]
        #output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(entry) + '\n') 

        if float(entry) >= -10.0 and float(entry) <= -7.78:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(255,255,217)' + '\n')  
        if float(entry) > -7.78 and float(entry) <= -5.56:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(237,248,177)' + '\n')  
        if float(entry) > -5.56 and float(entry) <= -3.34:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(199,233,180)' + '\n')  
        if float(entry) > -3.34 and float(entry) <= -1.12:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(127,205,187)' + '\n')  
        if float(entry) > -1.12 and float(entry) <= 1.1:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(65,182,196)' + '\n')  
        if float(entry) > 1.1 and float(entry) <= 3.32:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(29,145,192)' + '\n')  
        if float(entry) > 3.32 and float(entry) <= 5.54:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(34,94,168)' + '\n')  
        if float(entry) > 5.54 and float(entry) <= 7.76:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(37,52,148)' + '\n')  
        if float(entry) > 7.76 and float(entry) <= 10.0:
            output.writelines(str(cluster) + '\t' + str(start-cluster_start[cluster]) + '\t' + str(start-cluster_start[cluster]+1) + '\t' + str(entry) + '\t' + 'color=(8,29,88)' + '\n')  

        start += 1

    output.close()

    return
# -----------------------------------------------------------------------------------------------------------	
#"Spores" "UngerminatedSpores" "Haustoria" "X6dpi" "X9dpi" ""
writefile('spores.txt',-6)
writefile('ungerminatedspores.txt',-5)
writefile('haustoria.txt',-4)
writefile('6dpi.txt',-3)
writefile('9dpi.txt',-2)
# -----------------------------------------------------------------------------------------------------------	

