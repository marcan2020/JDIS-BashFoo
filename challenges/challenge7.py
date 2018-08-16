#!/usr/bin/env python
 
import SocketServer
import time
import threading
import random
 
class Service(SocketServer.BaseRequestHandler):
    def handle( self ):
       
        handle = open('flag.txt')
 
        while ( True ):
	    flag = handle.read()
            self.send( flag, newline = False )
 
    def send( self, string, newline = True ):
        if newline: string = string + "\n"
        self.request.sendall(string)  # this `request` object is internal to the BaseRequestHandler that we inherit.
 
    def receive( self, prompt = " > " ):
        self.send( prompt, newline = False )
        return self.request.recv( 4096 ).strip()
 
# this class literally doesn't need to do anything, but we need it to exist
# to make the threaded service and serve it up.
class ThreadedService( SocketServer.ThreadingMixIn, SocketServer.TCPServer, SocketServer.DatagramRequestHandler ):
    pass
 
def main():
 
    port = 1337       # we obviously need a port to run on...
    host = '0.0.0.0'  # the 0.0.0.0 host makes it visible to LAN
 
    service = Service # not an object, but at least use the class...
   
    # now we can create the server object, using the host and port that we define
    # and hosting our service (the class we will keep working on very soon!)
    server = ThreadedService( ( host, port ), service )
    server.allow_reuse_address = True
 
    server_thread = threading.Thread( target = server.serve_forever )
 
    server_thread.daemon = True
    server_thread.start()
 
    print "Server started on port", port
 
    # Now let the thread just do its thing. We'll wait and do nothing...
    try:
        while ( True ): time.sleep(60)
    except:
        pass
 
if ( __name__ == "__main__" ):
    main()
