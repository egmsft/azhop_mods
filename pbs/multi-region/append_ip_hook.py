import pbs
import socket
import sys

try:
    e = pbs.event()
    j = e.job
    submit_host = e.requestor_host
    ip_address = socket.gethostbyname(submit_host)
    j.Variable_List["AZHOP_SUBMIT_HOST"] = str(submit_host)
    j.Variable_List["AZHOP_SUBMIT_HOST_IP"] = str(ip_address)
except SystemExit:
    pass
except:
    e.reject("%s hook failed with %s. Please contact Admin" % (e.hook_name, sys.exc_info()[:2]))