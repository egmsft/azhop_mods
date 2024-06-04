import pbs
import socket

try:
    e = pbs.event()
    j = e.job
    hook_name = e.hook_name
    update_hosts = True

    if( j.Resource_List["place"] != None and 'shared' in repr(j.Resource_List["place"]) ) :
        update_hosts = False

    if( update_hosts ) :
        submit_host = j.Variable_List["AZHOP_SUBMIT_HOST"].split('.')[0]
        ip_address =  j.Variable_List["AZHOP_SUBMIT_HOST_IP"]

        ip_line =  "{ip}\t{host}\t{host}\n".format(ip = ip_address, host = submit_host)

        if e.type ==  pbs.EXECJOB_PROLOGUE:
            with open('/etc/hosts', 'a') as file:
                file.write(ip_line)

        elif e.type == pbs.EXECJOB_EPILOGUE:
            with open('/etc/hosts', 'r') as fr:
                lines = fr.readlines()

            with open('/etc/hosts', 'w') as fw:
                for line in lines:
                    if line.find(ip_line) == -1:
                        fw.write(line)
        else:
            pbs.logmsg(pbs.LOG_WARNING, '%s;%s;[ERROR] PBS event type %s not supported in this hook.' % (hook_name, job.id, pbs_event.type))
            pbs_event.accept()

except SystemExit:
    pass
except:
    e.reject("%s hook failed with %s. Please contact Admin" % (e.hook_name, sys.exc_info()[:2]))